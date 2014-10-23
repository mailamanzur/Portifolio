//
//  EditFriendsViewController.m
//  app2
//
//  Created by Maila Manzur on 8/7/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import "EditFriendsViewController.h"

@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Ocorreu um erro :%@ %@",error,[error userInfo]);
        }else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
        
    }];
    
    self.currentUser = [PFUser currentUser];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
        for (PFUser *friend in self.friends) {
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }
        [friendsRelation removeObject:user];
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.friends addObject:user];
        [friendsRelation addObject:user];
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Erros : %@ %@",error , [error userInfo]);
        }
    }];
    
}

-(BOOL)isFriend:(PFUser *)user{
    for (PFUser *friend in self.friends) {
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
        
    }
    
    return NO;
}



@end
