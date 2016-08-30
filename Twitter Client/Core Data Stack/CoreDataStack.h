//
//  CoreDataStack.h
//  Twitter Client
//
//  Created by Aleksey on 8/30/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

- (NSManagedObjectContext *)getMainObjectContext;

@end
