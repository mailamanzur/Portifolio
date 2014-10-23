//
//  LoginViewController.h
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(UIButton *)sender;
- (IBAction)FBLogin:(UIButton *)sender;

@end
