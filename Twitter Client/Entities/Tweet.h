//
//  Tweet.h
//  
//
//  Created by Aleksey on 8/31/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EasyMapping.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : EKManagedObjectModel <EKManagedMappingProtocol>

// Insert code here to declare functionality of your managed object subclass

+ (Tweet *)tweetWithDictionary:(NSDictionary *)dictionary
        inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)loadTweetsFromArray:(NSArray *)array
   intoManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Tweet+CoreDataProperties.h"
