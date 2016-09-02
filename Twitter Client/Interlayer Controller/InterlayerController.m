//
//  InterlayerController.m
//  Twitter Client
//
//  Created by Aleksey on 9/1/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "InterlayerController.h"
#import "TwitterService.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Tweet.h"

@interface InterlayerController ()

@property (nonatomic, strong) TwitterService *twitterService;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSManagedObjectContext *childContext;

@end

@implementation InterlayerController

#pragma mark - Designated initializer

- (instancetype)init
{
    if (self = [super init]) {
        _twitterService = [[TwitterService alloc] init];
        _mainContext = [[(AppDelegate *)([UIApplication sharedApplication].delegate) coreDataStack] getMainObjectContext];
    }
    return self;
}

#pragma mark - Setters & Getters

- (NSManagedObjectContext *)childContext
{
    if (!_childContext) {
        _childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_childContext setParentContext:self.mainContext];
    }
    return _childContext;
}

#pragma mark - Request and save tweets from feed into core data storage

- (void)requestTwitterFeedForAccount:(ACAccount *)account
                 withCompletionBlock:(CompletionBlockForUI)block
{
    [self.twitterService getUserFeedForAccount:account
                           withCompletionBlock:^(NSArray *tweets, NSError *error) {
                               if (!error && tweets.count && self.childContext && self.mainContext) {
                                   [self.childContext performBlock:^{
                                       [Tweet loadTweetsFromArray:tweets intoManagedObjectContext:self.childContext];
                                       [self.mainContext performBlock:^{
                                           NSError *error = nil;
                                           if ([self.mainContext hasChanges] && ![self.mainContext save:&error]) {
                                               NSLog(@"Unresolved error in main context %@, %@", error, [error userInfo]);
                                               abort();
                                           }
                                       }];
                                   }];
                                   block();
                               }
    }];
}

#pragma mark - Connection availability

- (BOOL)connection
{
    return [self.twitterService connectionIsAvailable];
}

@end
