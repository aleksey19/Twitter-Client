//
//  AlertManager.m
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
             forController:(UIViewController *)controller
{
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertControler dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertControler addAction:okAction];
    
    [controller presentViewController:alertControler animated:YES completion:nil];
}

@end
