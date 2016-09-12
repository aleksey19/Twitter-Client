//
//  TwitterViewController.m
//  Twitter Client
//
//  Created by Aleksey on 8/30/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "TwitterViewController.h"
#import <CoreData/CoreData.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "InterlayerController.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "AlertManager.h"

@interface TwitterViewController ()

@property (nonatomic, strong) InterlayerController *interlayerController;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) ACAccount *account;

@property (weak, nonatomic) IBOutlet UIRefreshControl *spinner;

@end

@implementation TwitterViewController

#pragma mark - Setters & Getters

- (InterlayerController *)interlayerController
{
    if (!_interlayerController) {
        _interlayerController = [[InterlayerController alloc] init];
    }
    return _interlayerController;
}

- (NSManagedObjectContext *)mainContext
{
    if (!_mainContext) {
        CoreDataStack *coreDataStack = [(AppDelegate *)([UIApplication sharedApplication].delegate) coreDataStack];
        _mainContext = [coreDataStack getMainObjectContext];
        _mainContext.undoManager = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
        request.predicate = nil;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created_at" ascending:NO]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.mainContext sectionNameKeyPath:nil cacheName:nil];
    }
    return _mainContext;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    [self getAccessToTwitterAccount];
}

- (void)setupView
{
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *tweetItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"make_tweet"] style:UIBarButtonItemStylePlain target:self action:@selector(composeTweet)];
    self.navigationItem.rightBarButtonItems = @[tweetItem];
    
    self.tableView.estimatedRowHeight = 240.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    NSLog(@"%@", self.mainContext);
}

- (void)setupNavBarTitle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationController.topViewController.title = self.account.username;
    });
}

#pragma mark - Refreshing

- (IBAction)refreshTableView
{
    [self.spinner beginRefreshing];
    [self requestTweets];
}

#pragma mark - Get access to twitter account

- (void)getAccessToTwitterAccount
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountTypeTwitter = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountTypeTwitter
                                          options:nil
                                       completion:^(BOOL granted, NSError *error) {
                                           if (granted) {
                                               NSArray *accounts = [accountStore accountsWithAccountType:accountTypeTwitter];
                                               
                                               if (accounts.count) {
                                                   self.account = [accounts lastObject];
                                                   
                                                   
                                                   [self setupNavBarTitle];
                                                   [self requestTweets];
                                                   
                                               } else {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       [AlertManager showAlertWithTitle:@"Access error" message:@"Add twitter account in settings before authorization." forController:self];
                                                   });
                                               }
                                           } else {
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   [AlertManager showAlertWithTitle:@"Access error" message:@"Sorry, can't authorize without access to your twitter account." forController:self];
                                               });
                                           }
                                       }];
}

#pragma mark - Request tweets

- (void)requestTweets
{
    if ([self.interlayerController connection]) {
        [self.interlayerController requestTwitterFeedForAccount:self.account withCompletionBlock:^{
            [self.spinner endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [AlertManager showAlertWithTitle:@"No internet" message:@"Can't proceed request. Please check internet connection." forController:self];
        });
    }
}

#pragma mark - Compose tweet

- (void)composeTweet
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        if ([self.interlayerController connection]) {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Make a tweet"];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        } else {
            [AlertManager showAlertWithTitle:@"No internet" message:@"Can't proceed request. Please check internet connection." forController:self];
        }
    }
}

#pragma mark - Table view data source

- (void)configureCell:(TweetCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    Tweet *tweet = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.authorNameLabel.text = tweet.author_name;
    cell.tweetDateLabel.text = [NSString stringWithFormat:@"%@", tweet.created_at];
    cell.tweetTextLabel.text = tweet.tweet_text;
    
    [cell.authorAvatarImageView sd_setImageWithURL:[NSURL URLWithString:tweet.author_avatar_url]
                                  placeholderImage:[UIImage imageNamed:@"placeholder_avatar"]
                                           options:SDWebImageProgressiveDownload];
    cell.authorAvatarImageView.layer.cornerRadius = 5.0f;
    
    [cell.tweetImageView sd_setImageWithURL:[NSURL URLWithString:tweet.image_url]
                           placeholderImage:[UIImage imageNamed:@"tweet_placeholder_image"]
                                    options:SDWebImageRefreshCached];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Status bar style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
