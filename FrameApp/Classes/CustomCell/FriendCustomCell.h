//
//  FriendCustomCell.h
//  Frame
//
//  Created by Hardik on 8/16/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface FriendCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet EGOImageView *imgProfilePic;
@property (strong, nonatomic) IBOutlet UIButton *btnAddFriend;
@property (strong, nonatomic) IBOutlet UIButton *btnRejectFriend;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

@end
