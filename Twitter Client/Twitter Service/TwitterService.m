//
//  TwitterService.m
//  Twitter Client
//
//  Created by Aleksey on 8/31/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "TwitterService.h"
#import <Social/Social.h>
#import "Reachability.h"

@interface TwitterService ()

@end

@implementation TwitterService

#pragma mark - Designated initializer

- (instancetype)init
{
    if (self = [super init]) {
        //
    }
    return self;
}

#pragma mark - Get user's feed

- (void)getUserFeedForAccount:(ACAccount *)twitterAccount
          withCompletionBlock:(CompletionBlock)block
{
    NSDictionary *params = @{@"count" : @"10"};
    
    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    
    SLRequest *feedRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:params];
    feedRequest.account = twitterAccount;
    
    [feedRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSError *serializationError;
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&serializationError];
        
        if (!error && responseArray.count) {
            block(responseArray, nil);
        }
        
        
    }];
}

#pragma mark - Check internet connection

- (BOOL)connectionIsAvailable
{
    Reachability *IsReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus internetStats = [IsReachable currentReachabilityStatus];
    
    return (internetStats == NotReachable) ? (NO) : (YES);
}

@end
