//
//  EKManagedObjectModel+UnitTests.m
//  Twitter Client
//
//  Created by Aleksey on 9/3/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "EKManagedObjectModel+UnitTests.h"

@implementation EKManagedObjectModel (UnitTests)

- (NSNumber *)validateValue:(id)value forSelector:(SEL)selector
{
    return @([self validateValue:&value forKey:NSStringFromSelector(selector) error:nil]);
}

- (NSPropertyDescription *)propertyBySelector:(SEL)selector
{
    return self.entity.propertiesByName[NSStringFromSelector(selector)];
}

@end
