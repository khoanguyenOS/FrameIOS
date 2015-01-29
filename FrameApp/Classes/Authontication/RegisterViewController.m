//
//  RegisterViewController.m
//  FrameApp
//
//  Created by Hardik on 8/5/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProfilePicViewController.h"
#import "ProfileViewController.h"
#import "JSONKit.h"

@interface RegisterViewController ()

@end
@implementation RegisterViewController
@synthesize strEmail,strPassword,dicUserInfo;
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
    self.title=@"SIGN UP";
    [self.view setBackgroundColor:[UIColor yellowColor]];
    [_txtFullName becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    [self btnRegisterPressed:nil];
    return YES;

}
- (IBAction)btnRegisterPressed:(id)sender {

    // [self.navigationController pushViewController:proPicVC animated:YES];
    
    if([self isValidation]){
        [_txtPhoneNo resignFirstResponder];
        [_txtFullName resignFirstResponder];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    NSLog(@"%s", __FUNCTION__);
        @try {

            NSURL *url = [NSURL URLWithString:@"http://api.frame.com/account/register"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:strEmail forKey:@"Email"];
            [dic setValue:strPassword forKey:@"Password"];
            [dic setValue:_txtFullName.text forKey:@"FullName"];

            // [dic setValue:_txtPhoneNo forKey:@"PhoneNo"];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
            [request setRequestMethod:@"POST"];
                   [request setDelegate:self];

            // [request addPostValue:[dic JSONString] forKey:@""];
            [request startAsynchronous];
            NSData *data=[dic JSONData];
            [request appendPostData:data];
             dic = nil;
            
        }
        @catch (NSException *exception) {
            NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
        }
//   }
    }
 
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%s", __FUNCTION__);
    @try {
        
        NSString *responseString = [request responseString];
        NSDictionary *dic = [responseString objectFromJSONString];
        
        
        NSLog(@"%@",dic);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if([[dicError objectForKey:@"Message"]length]>0){
                DisplayAlert([dicError objectForKey:@"Message"]);
            }else{
                DisplayAlert([dicError objectForKey:@"Name"]);
            }
            
        }else{
            //Login Calling
            
            NSString *strParam = [NSString stringWithFormat:@"signin/%@/%@",strEmail,strPassword];
            //  NSString *strParam = [NSString stringWithFormat:@"&lat=%@&long=%@&iPage=%@",@"-33.7775849",@"150.9078043",@"0"];
           JSONParser *parser = [[JSONParser alloc]initWith_withURL:WebURLAccount withParam:strParam withType:@"NORMAL" withSelector:@selector(getLoginSuccessfully:) withObject:self];
            
//            ProfilePicViewController *proPicVC=[[ProfilePicViewController alloc] initWithNibName:@"ProfilePicViewController" bundle:nil];
//            [self.navigationController pushViewController:proPicVC animated:YES];

        }

    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }

    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Failed --> %s: %@", __FUNCTION__, error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)isValidation{
    
    if([self isStringBlank:_txtFullName.text]){
        DisplayAlert(@"please enter full name.");
        return NO;
//    }else if([self isStringBlank:_txtPhoneNo.text]){
//        DisplayAlert(@"please enter phone number");
//        return NO;
   }else {
        return YES;
    }
    
    return YES;
    
}

-(void)getLoginSuccessfully:(NSDictionary *)dictLogin
{
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //[self stopRotatingReload];
    NSLog(@"%@",dictLogin);
    
    NSDictionary *dicError=[dictLogin valueForKey:@"Error"];
    NSString *strCode=[dicError objectForKey:@"Code"];
    if([[dicError objectForKey:@"Code"] intValue]!=0){
        DisplayAlert([dicError objectForKey:@"Message"]);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        appDelegate.dicUserInfo=[dictLogin objectForKey:@"Target"];
      
     //   ProfileViewController *profileVC=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
      //  profileVC.dicLogedUserInfo=[dictLogin objectForKey:@"Target"];
      //  [self.navigationController pushViewController:profileVC animated:YES];

            ProfilePicViewController *profileVC=[[ProfilePicViewController alloc] initWithNibName:@"ProfilePicViewController" bundle:nil];
            profileVC.dicUserInfo=[dictLogin objectForKey:@"Target"];
            [self.navigationController pushViewController:profileVC animated:YES];
        
        
        
    }
    
    
}
- (BOOL)isStringBlank:(NSString *)str
{
    if([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return TRUE;
    }
    return FALSE;
    
}
@end
