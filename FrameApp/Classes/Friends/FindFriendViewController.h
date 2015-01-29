//
//  FindFriendViewController.h
//  Frame
//
//  Created by Hardik on 8/16/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFriendViewController : UIViewController<NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblFindFriend;
@property (strong, nonatomic) IBOutlet UITableView *tblReqFriend;
@property (strong, nonatomic) IBOutlet UITableView *tblFriend;
@property(strong,nonatomic)NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentFrnd;
@property(strong,nonatomic)NSMutableArray *aryFindFriends;
@property(strong,nonatomic)NSMutableArray *aryReqFriends;
@property(strong,nonatomic)NSMutableArray *aryFriends;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)segValueChange:(id)sender;
@end
