//
//  FriendsViewController.h
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsViewController : UITableViewController
@property(nonatomic,strong)PFRelation *friendsRelation;
@property(nonatomic,strong)NSArray *friends;

@end
