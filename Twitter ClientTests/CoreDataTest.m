//
//  CoreDataTest.m
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "Tweet.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"

SPEC_BEGIN(CoreDataTest)

describe(@"Test managed object", ^{
    __block Tweet *tweet;
    __block CoreDataStack *cds;
    
    beforeEach(^{
        
        [cds stub:@selector(initWithStorageType:) andReturn:NSInMemoryStoreType];
        //        cds = [[CoreDataStack alloc] initWithStorageType:NSInMemoryStoreType];
        tweet = [Tweet tweetWithDictionary:@{@"created_at" : @"now",
                                             @"id" : @"110",
                                             @"retweet_count" : @"12",
                                             @"text" : @"Tweet for unit testing",
                                             @"user.name" : @"Tester"}
                    inManagedObjectContext:[cds getMainObjectContext]];
    });
    
    it(@"Should not be an abstract entity", ^{
        [[theValue(tweet.entity.isAbstract) should] beNo];
    });
    
    it(@"Should not have a parent entity", ^{
        [[tweet.entity.superentity should] beNil];
    });
    
    it(@"Shiuld not have a compound index", ^{
        [[tweet.entity.compoundIndexes should] beNil];
    });
    
    it(@"Can save with valid data", ^{
        
        tweet.tweet_id = @111;
        tweet.tweet_text = @"New text";
        
        [cds saveContext:[cds getMainObjectContext]];
        
        [[tweet.tweet_id should] beGreaterThanOrEqualTo:@111];
        
    });
    
});

SPEC_END