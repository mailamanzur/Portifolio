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
@end
