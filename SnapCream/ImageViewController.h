//
//  ImageViewController.h
//  app2
//
//  Created by Maila Manzur on 8/15/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController
@property(nonatomic,strong)PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
