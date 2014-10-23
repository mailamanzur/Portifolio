//
//  inboxViewController.h
//  app2
//
//  Created by Maila Manzur on 8/8/14.
//  Copyright (c) 2014 maila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface inboxViewController : UITableViewController

@property(nonatomic ,strong)NSArray *messages;
@property(nonatomic,strong)PFObject *selectedMessage;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
- (IBAction)logout:(UIBarButtonItem *)sender;


@end
