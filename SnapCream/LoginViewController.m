//
//  LoginViewController.m
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
[super viewDidLoad];

self.password.delegate = self;
self.username.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];



[self.navigationController.navigationBar setHidden:YES];
}



- (IBAction)login:(UIButton *)sender {

NSString *user = [self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

NSString *fieldpassword = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

if ([user length] == 0) {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Olá" message:@"Preencha todos os campos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}else{
    [ PFUser logInWithUsernameInBackground:user password:fieldpassword block:^(PFUser *user, NSError *error) {
        if (error) {
            UIAlertView *alertbad = [[UIAlertView alloc]initWithTitle:@"Há um erro na seu usuário/senha" message:[error.userInfo objectForKey:@"error"]
                                                             delegate:nil
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil, nil];
            [alertbad show];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
}

- (IBAction)FBLogin:(UIButton *)sender {

NSArray *permissionsArray = @[@"user_about_me",@"user_relationships",@"user_birthday",@"user_location"];

//Login PFUser using Facebook

[PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {

if (!user) {
    NSString *errorMessage = nil;
    
    if (!error) {
        NSLog(@"The user cancelled the facebook login");
        errorMessage = @"user cancelled the Facebook login";
    }else{
        NSLog(@"An error ocurred: %@",error);
        errorMessage = [error localizedDescription];
    }
    
    UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"Log In Error" message:errorMessage
                                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alert show];
}else{
    if (user.isNew) {
        NSLog(@"User with Facebook signed up and logged in");
    }else{
        NSLog(@"User with Facebook logged in!");
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



}];






}

#pragma Keyboard Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

[self.view endEditing:YES];

}


-(void)textFieldDidEndEditing:(UITextField *)textField{

[UIView animateWithDuration:0.3 animations:^{
    CGPoint adjust;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            adjust = CGPointMake(110, 0);
            break;
        case UIInterfaceOrientationLandscapeRight:
            adjust = CGPointMake(-110, 0);
            break;
        default:
            adjust = CGPointMake(0, 220);
            break;
    }
    CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
    [self.view setCenter:newCenter];
}];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

NSLog(@"WOLOLO");
[UIView animateWithDuration:0.3 animations:^{
    CGPoint adjust;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            adjust = CGPointMake(-330, 0);
            break;
        case UIInterfaceOrientationLandscapeRight:
            adjust = CGPointMake(330, 0);
            break;
        default:
            adjust = CGPointMake(0, -210);
            break;
    }
    CGPoint newCenter = CGPointMake(self.view.center.x+adjust.x, self.view.center.y+adjust.y);
    [self.view setCenter:newCenter];
}];}
@end
