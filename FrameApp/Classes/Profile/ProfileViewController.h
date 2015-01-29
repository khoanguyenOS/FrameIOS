//
//  ProfileViewController.h
//  FrameApp
//
//  Created by Hardik on 8/8/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface ProfileViewController : UIViewController<NSURLConnectionDelegate>

@property(strong,nonatomic)NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UIButton *btnProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *lblFullName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhoneNumber;

@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet EGOImageView *imgViewProfilepic;

@property(strong,nonatomic)NSMutableDictionary *dicLogedUserInfo;
@property(strong,nonatomic)NSMutableDictionary *dicProfileInfo;
- (IBAction)btnGroupPressed:(id)sender;
@end
