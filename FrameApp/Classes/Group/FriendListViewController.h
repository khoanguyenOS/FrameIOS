//
//  FriendListViewController.h
//  Frame
//
//  Created by Hardik on 9/4/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol picFriendsDelegate <NSObject>
@required
- (void)picFriendsDidFinish:(NSDictionary*)dicSectedFrnd;
@end
@interface FriendListViewController : UIViewController<NSURLConnectionDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblBGFriends;
@property(strong,nonatomic)NSMutableData *responseData;
- (IBAction)btnClosePressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblFriendList;
@property(strong,nonatomic)NSMutableArray *aryFriends;
@property(strong,nonatomic)id <picFriendsDelegate> delegate;

@end
