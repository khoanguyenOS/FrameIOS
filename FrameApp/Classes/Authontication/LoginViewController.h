//
//  LoginViewController.h
//  FrameApp
//
//  Created by Hardik on 8/5/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<NSURLConnectionDelegate>

@property(strong,nonatomic)NSMutableData *responseData;
- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnSigninPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UIView *viewFullname;
@property(nonatomic)BOOL isSignUp;

@end
