//
//  TwitterService.h
//  Twitter Client
//
//  Created by Aleksey on 8/31/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

typedef void(^CompletionBlock)(NSArray *tweets, NSError *error);

@interface TwitterService : NSObject

- (void)getUserFeedForAccount:(ACAccount *)twitterAccount
          withCompletionBlock:(CompletionBlock)block;
- (BOOL)connectionIsAvailable;

@end
