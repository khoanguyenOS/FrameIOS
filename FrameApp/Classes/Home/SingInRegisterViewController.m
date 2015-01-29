//
//  SingInRegisterViewController.m
//  FrameApp
//
//  Created by Hardik on 8/6/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "SingInRegisterViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface SingInRegisterViewController ()
@end

@implementation SingInRegisterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginPressed:(id)sender {
    
    LoginViewController *loginVc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginVc.isSignUp=NO;
    [self.navigationController pushViewController:loginVc animated:YES];
    
}
- (IBAction)btnSignUpPressed:(id)sender {
    LoginViewController *loginVc=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginVc.isSignUp=YES;
    [self.navigationController pushViewController:loginVc animated:YES];


}
@end
