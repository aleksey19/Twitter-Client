//
//  Tweet+CoreDataProperties.m
//  
//
//  Created by Aleksey on 8/31/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tweet+CoreDataProperties.h"

@implementation Tweet (CoreDataProperties)

@dynamic tweet_id;
@dynamic created_at;
@dynamic image_url;
@dynamic tweet_text;
@dynamic author_name;
@dynamic author_avatar_url;
@dynamic retweet_count;

@end
