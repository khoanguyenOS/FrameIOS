//
//  ProfilePicViewController.h
//  FrameApp
//
//  Created by Hardik on 8/6/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePicViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSURLConnectionDelegate>
- (IBAction)btnProfilePicPressed:(id)sender;
@property(strong,nonatomic)NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UIButton *btnProfilePic;
@property(strong,nonatomic)NSMutableDictionary *dicUserInfo;
@property(strong,nonatomic)UIImage *imgUserPic;
- (IBAction)btnDonePressed:(id)sender;

@end
