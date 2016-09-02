//
//  InterlayerController.h
//  Twitter Client
//
//  Created by Aleksey on 9/1/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

typedef void(^CompletionBlockForUI)();

@interface InterlayerController : NSObject

- (void)requestTwitterFeedForAccount:(ACAccount *)account
                 withCompletionBlock:(CompletionBlockForUI)block;
- (BOOL)connection;

@end
