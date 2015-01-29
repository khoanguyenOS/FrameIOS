//
//  LoginViewController.m
//  FrameApp
//
//  Created by Hardik on 8/5/13.
//  Copyright (c) 2013 openXcell. All rights reserved.

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "common.h"

#import "Global.h"
#import "ProfileViewController.h"
#import "ProfilePicViewController.h"
#import "JSONKit.h"
@interface LoginViewController ()

@end
@implementation LoginViewController
    JSONParser *parser;
@synthesize isSignUp,viewFullname;
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
     [self.navigationController.navigationBar setHidden:NO];
    // Do any additional setup after loading the view from its nib.
    if(isSignUp){
        self.title=@"SIGN UP";
        viewFullname.hidden=NO;
        _txtPassword.returnKeyType=UIReturnKeyNext;
    }
    else{
        self.title=@"LOGIN";
        viewFullname.hidden=YES;
    
    }
    [self.view setBackgroundColor:[UIColor yellowColor]];
    [_txtEmail becomeFirstResponder];

}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    // Do any additional setup after loading the view from its nib.
    if(isSignUp){
        self.title=@"SIGN UP";
        viewFullname.hidden=NO;
         _txtPassword.returnKeyType=UIReturnKeyNext;
    }
    else{
        self.title=@"LOGIN";
        viewFullname.hidden=YES;
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRegisterPressed:(id)sender {

//    if([self isValidation]){
//        RegisterViewController *registerVC=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
//        registerVC.strEmail=_txtEmail.text;
//        registerVC.strPassword=_txtPassword.text;
//        [self.navigationController pushViewController:registerVC animated:YES];
//    }
// [self.navigationController pushViewController:proPicVC animated:YES];

    if([self isValidation]){
       
        [_txtFullName resignFirstResponder];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSLog(@"%s", __FUNCTION__);
        @try {
            
            NSURL *url = [NSURL URLWithString:@"http://api.frame.com/account/register"];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            [dic setValue:_txtEmail.text forKey:@"Email"];
            [dic setValue:_txtPassword.text forKey:@"Password"];
            [dic setValue:_txtFullName.text forKey:@"FullName"];
            // [dic setValue:_txtPhoneNo forKey:@"PhoneNo"];
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
            [request setRequestMethod:@"POST"];
            [request setDelegate:self];
            [request setTag:100];
            [request startAsynchronous];
           // [request appendPostData:[dic JSONData]];
            NSData *data=[dic JSONData];
            [request appendPostData:data];
            
            
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//            // Specify that it will be a POST request
//            request.HTTPMethod = @"POST";
//            // This is how we set header fields
//            [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//            
//            // Convert your data and set your request's HTTPBody property
//            
//            
//            NSError *error;
//            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//            [request setHTTPBody:jsonData];
//            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            

            dic = nil;
            
        }
        @catch (NSException *exception) {
            NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
        }
        //   }
    }
    
}

- (IBAction)btnSigninPressed:(id)sender {

    if([self isValidation]){
        [_txtEmail resignFirstResponder];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([appDelegate InternetConnectionFlag]==0)
        {
            DisplayAlert(@"please chcek network Connection");
        }
        else
        {
            //Rotate Image Reload
            //[self startRotatingReload];
            //Show Notification View
            //there are stations with : lat-23.0545903, lon-72.51974339999992
            //Get Data &userid=%@ = [[[NSUserDefaults standardUserDefaults] valueForKey:@"user_info"]valueForKey:@"iUserID"]
            NSString *strParam = [NSString stringWithFormat:@"signin/%@/%@",_txtEmail.text,_txtPassword.text];
            //  NSString *strParam = [NSString stringWithFormat:@"&lat=%@&long=%@&iPage=%@",@"-33.7775849",@"150.9078043",@"0"];
            parser = [[JSONParser alloc]initWith_withURL:WebURLAccount withParam:strParam withType:@"NORMAL" withSelector:@selector(getLoginSuccessfully:) withObject:self];
        
        }
        
    }

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
    }else{
        appDelegate.dicUserInfo=[dictLogin objectForKey:@"Target"];
        if(isSignUp){
//            ProfilePicViewController *profileVC=[[ProfilePicViewController alloc] initWithNibName:@"ProfilePicViewController" bundle:nil];
//            profileVC.dicUserInfo=[dictLogin objectForKey:@"Target"];
//            [self.navigationController pushViewController:profileVC animated:YES];
            ProfileViewController *profileVC=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
            profileVC.dicLogedUserInfo=[dictLogin objectForKey:@"Target"];
            [self.navigationController pushViewController:profileVC animated:YES];

        }else{
            ProfileViewController *profileVC=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
            profileVC.dicLogedUserInfo=[dictLogin objectForKey:@"Target"];
            [self.navigationController pushViewController:profileVC animated:YES];
        }

//        ProfilePicViewController *profileVC=[[ProfilePicViewController alloc] initWithNibName:@"ProfilePicViewController" bundle:nil];
//        profileVC.dicUserInfo=[dictLogin objectForKey:@"Target"];
//        [self.navigationController pushViewController:profileVC animated:YES];
        
        appDelegate.dicUserInfo=[dictLogin objectForKey:@"Target"];

    }

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    if(request.tag==100){

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
                
                NSString *strParam = [NSString stringWithFormat:@"signin/%@/%@",_txtEmail.text,_txtPassword.text];
                //  NSString *strParam = [NSString stringWithFormat:@"&lat=%@&long=%@&iPage=%@",@"-33.7775849",@"150.9078043",@"0"];
                JSONParser *parser = [[JSONParser alloc]initWith_withURL:WebURLAccount withParam:strParam withType:@"NORMAL" withSelector:@selector(getLoginSuccessfully:) withObject:self];
                
                //            ProfilePicViewController *proPicVC=[[ProfilePicViewController alloc] initWithNibName:@"ProfilePicViewController" bundle:nil];
                //            [self.navigationController pushViewController:proPicVC animated:YES];
                
            }

        }
        @catch (NSException *exception) {
            NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
        }

    }else{
    
    NSLog(@"%s", __FUNCTION__);
    @try {
        NSString *responseString = [request responseString];
        //NSDictionary *dic = [responseString objectFromJSONString];
        NSLog(@"dic :: %@",responseString);

    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Failed --> %s: %@", __FUNCTION__, error);
}
#pragma mark - TextField Delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if(textField==_txtEmail)
        [_txtPassword becomeFirstResponder];
    else if(textField==_txtPassword){
        if(isSignUp){
            [_txtFullName becomeFirstResponder];
            
        }
        else{
            [textField resignFirstResponder];
            [self btnSigninPressed:nil];
        }
      
    }
    else if(textField==_txtFullName){
        [textField resignFirstResponder];
        [self  btnRegisterPressed:nil];
    }
    
    return YES;

}
-(BOOL)isValidation{

    if([self isStringBlank:_txtEmail.text]){
        DisplayAlert(@"Please enter email.")
        return NO;
    }else if (![self validateEmail:_txtEmail.text]){
        DisplayAlert(@"Please enter valid email address.");
        return NO;
    }else if([self isStringBlank:_txtPassword.text]){
        DisplayAlert(@"Please enter password")
        return NO;
    }else if(_txtPassword.text.length <6){
        DisplayAlert(@"Please enter minimum six charactor password.")
        return NO;
    }else {
        return YES;
    }

    return YES;
}

- (BOOL)isStringBlank:(NSString *)str
{
    if([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return TRUE;
    }
    return FALSE;
    
}
- (BOOL) validateEmail: (NSString *) email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
       
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [_responseData appendData:data];
    NSString *responseString= [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSLog(@"responseString = %@",responseString);
    NSDictionary *dic = [responseString objectFromJSONString];
  //  NSLog(@"dic :: %@",responseString);
    
    NSDictionary *dicError=[dic valueForKey:@"Error"];
    NSString *strCode=[dicError objectForKey:@"Code"];
    if([[dicError objectForKey:@"Code"] intValue]!=0){
        DisplayAlert([dicError objectForKey:@"Message"]);
    }else{
            
    
    }
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
@end
