//
//  AlertManager.h
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertManager : NSObject

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
             forController:(UIViewController *)controller;

@end
