//
//  CameraViewController.m
//  app2
//
//  Created by Maila Manzur on 8/9/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface CameraViewController ()

@end

@implementation CameraViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendsRelation = [[PFUser currentUser]objectForKey:@"friendsRelation"];
    self.recipients= [[NSMutableArray alloc]init];
   
    
    
  
}
    -(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

        PFQuery *query = [self.friendsRelation query];
        [query orderByAscending:@"username"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"%@ %@",error,[error userInfo]);
            }else {
                self.friends = objects;
                [self.tableView reloadData];
            }
        }];
        

    if (self.image == nil && [self.videoFilePath length] == 0) {

    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.videoMaximumDuration = 10;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;    }
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];

    [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.friends count];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
}

    -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
        
    }else{
        NSURL *imagePickerURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self.videoFilePath = [imagePickerURL path];
    }if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);
      }
        
        
    }



    [self dismissViewControllerAnimated:YES completion:nil];
    }


    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;

    if ([self.recipients containsObject:user.objectId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }


    return cell;
    }

    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.recipients addObject:user.objectId];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipients removeObject:user.objectId];
    }

    NSLog(@"%@",self.recipients);
    }

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)send:(UIBarButtonItem *)sender {
    if(self.image == nil && [self.videoFilePath length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Try Again!"
                                                           message:@"Please Capture or select a photo or video to share"
                                                          delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    else {
        [self uploadMessage];
        [self.tabBarController setSelectedIndex:0];
    }
    
    
}



- (IBAction)cancel:(UIBarButtonItem *)sender {
    
    [self reset];
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - Helper Methods


- (void)reset {
    self.image = nil;
    self.videoFilePath = nil;
    [self.recipients removeAllObjects];
}
-(void)uploadMessage{
    
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    if (self.image != nil) {
       UIImage *newImage = [self resizeImage:self.image toWidth:320.0f andHeight:480.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    }
    else{
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";
        
    }
    
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"An error Occurred!"
                                                               message:@"Please try sending your message again."
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles: nil];
            [alertView show];
        }else{
        
            
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey: @"file"];
            [message setObject:fileType forKey:@"fileType"];
            [message setObject:self.recipients forKey:@"recipientsIds"];
            [message setObject:[[PFUser currentUser]objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser]username]  forKey:@"senderName"];
            
            
            
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"An error Occurred!"
                                                                       message:@"Please try sending your message again."
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles: nil];
                [alertView show];
                }
                
                else {
                       [self reset];
                }
            }];
            
        }
    }];
}
-(UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


@end
