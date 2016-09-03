//
//  EKManagedObjectModel+UnitTests.h
//  Twitter Client
//
//  Created by Aleksey on 9/3/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <EasyMapping/EasyMapping.h>

@interface EKManagedObjectModel (UnitTests)

-(NSNumber *)validateValue:(id)value forSelector:(SEL)selector;
-(NSPropertyDescription *)propertyBySelector:(SEL)selector;

@end
