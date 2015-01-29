//
//  RegisterViewController.h
//  FrameApp
//
//  Created by Hardik on 8/5/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNo;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;

@property (strong,nonatomic) NSString *strEmail;
@property(strong,nonatomic) NSString *strPassword;

@property(strong,nonatomic)NSMutableDictionary *dicUserInfo;
- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;

@end
