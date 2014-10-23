//
//  SignUpViewController.h
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernametxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailtxtField;

- (IBAction)signUP:(UIButton *)sender;

@end
