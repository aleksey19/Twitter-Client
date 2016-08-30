//
//  AppDelegate.h
//  Twitter Client
//
//  Created by Aleksey on 8/30/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CoreDataStack *coreDataStack;

@end

