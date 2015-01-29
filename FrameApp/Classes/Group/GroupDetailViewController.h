//
//  GroupDetailViewController.h
//  Frame
//
//  Created by Hardik on 8/29/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListViewController.h"
@interface GroupDetailViewController :  UIViewController<NSURLConnectionDelegate,picFriendsDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblGroupFriendList;
@property(strong,nonatomic)NSMutableData *responseData;
@property(strong,nonatomic)NSMutableArray *aryGroupFriends;
@property(strong,nonatomic)NSString *strSelectedGroupID;

@end
