//
//  Tweet.m
//  
//
//  Created by Aleksey on 8/31/16.
//
//

#import "Tweet.h"

@implementation Tweet

// Insert code here to add functionality to your managed object subclass

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:@"Tweet" withBlock:^(EKManagedObjectMapping *mapping) {
        [mapping mapKeyPath:@"created_at" toProperty:@"created_at"];
        [mapping mapKeyPath:@"entities.media.media_url" toProperty:@"image_url"];
        [mapping mapKeyPath:@"id" toProperty:@"tweet_id"];
        [mapping mapKeyPath:@"retweet_count" toProperty:@"retweet_count"];
        [mapping mapKeyPath:@"text" toProperty:@"tweet_text"];
        [mapping mapKeyPath:@"user.name" toProperty:@"author_name"];
        [mapping mapKeyPath:@"user.profile_image_url" toProperty:@"author_avatar_url"];
    }];
}

+ (Tweet *)tweetWithDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Tweet *tweet = nil;
    
    NSInteger tweet_id = [dictionary[@"id"] integerValue];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
    request.predicate = [NSPredicate predicateWithFormat:@"tweet_id = %ld", (long)tweet_id];
    
    NSError *error = nil;
    NSArray *tweets = [context executeFetchRequest:request error:&error];
    
    request.predicate = nil;
    NSArray *tweets2 = [context executeFetchRequest:request error:&error];
    
    if (error || (tweets.count > 1) || !tweets) {
#warning handle case
    }
    else if (tweets.count == 1) {
        tweet = [tweets lastObject];
    }
    else if (!tweets.count) {
        // Mapping
        tweet = [Tweet objectWithProperties:dictionary inContext:context];
        
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error in child context %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return tweet;
}

+ (void)loadTweetsFromArray:(NSArray *)array
   intoManagedObjectContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *tweet in array) {
        [self tweetWithDictionary:tweet inManagedObjectContext:context];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tweet {\n id: %@\n created_at: %@\n image_url: %@\n retweet_count: %@\n text: %@\n user_name: %@\n user_avatar_url: %@\n}", self.tweet_id, self.created_at, self.image_url, self.retweet_count, self.tweet_text, self.author_name, self.author_avatar_url];
}

@end
