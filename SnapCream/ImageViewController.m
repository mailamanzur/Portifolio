//
//  ImageViewController.m
//  app2
//
//  Created by Maila Manzur on 8/15/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc]initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@",senderName];
    self.navigationItem.title = title;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(timeout)]) {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
        
    }else{
        NSLog(@"Error:selector missing!");
    }
}

-(void)timeout {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
