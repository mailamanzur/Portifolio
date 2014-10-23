//
//  EditFriendsViewController.h
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController
@property(nonatomic,strong)NSArray *allUsers;
@property(nonatomic,strong)PFUser *currentUser;
@property(nonatomic, strong)NSMutableArray *friends;

-(BOOL)isFriend:(PFUser *)user;


@end
