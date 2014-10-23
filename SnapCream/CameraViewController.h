//
//  CameraViewController.h
//  app2
//
//  Created by Maila Manzur on 8/9/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CameraViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic ,strong)UIImagePickerController *imagePicker;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *videoFilePath;
@property(nonatomic,strong)NSArray *friends;
@property(nonatomic,strong)PFRelation *friendsRelation;
@property(nonatomic,strong)NSMutableArray *recipients;
- (IBAction)send:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
-(void)uploadMessage;
-(UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;

@end
