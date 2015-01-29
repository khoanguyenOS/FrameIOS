//
//  EditProfileViewController.h
//  FrameApp
//
//  Created by Hardik on 8/12/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
@interface EditProfileViewController : UIViewController<NSURLConnectionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)NSMutableData *responseData;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property(strong,nonatomic) NSMutableDictionary *dicProfileData;
@property(strong,nonatomic)UIImage *imgUserPic;
@property (strong, nonatomic) IBOutlet UIButton *btnProfileImg;
- (IBAction)btnProfilePicPressed:(id)sender;


@end
