//
//  Tweet+CoreDataProperties.h
//  
//
//  Created by Aleksey on 9/12/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author_avatar_url;
@property (nullable, nonatomic, retain) NSString *author_name;
@property (nullable, nonatomic, retain) NSString *created_at;
@property (nullable, nonatomic, retain) NSString *image_url;
@property (nullable, nonatomic, retain) NSNumber *retweet_count;
@property (nullable, nonatomic, retain) NSNumber *tweet_id;
@property (nullable, nonatomic, retain) NSString *tweet_text;

@end

NS_ASSUME_NONNULL_END
