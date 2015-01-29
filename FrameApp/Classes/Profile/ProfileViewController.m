//
//  ProfileViewController.m
//  FrameApp
//
//  Created by Hardik on 8/8/13.
//  Copyright (c) 2013 openXcell. All rights reserved.

#import "ProfileViewController.h"
#import "JSONKit.h"
#import "EditProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FindFriendViewController.h";
#import "GroupListViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize dicLogedUserInfo,dicProfileInfo;
NSMutableDictionary *dic;
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
    self.title=@"PROFILE";
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    // Do any additional setup after loading the view from its nib.
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"EDIT" style:UIBarButtonItemStylePlain target:self action:@selector(btnEditPressed:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"LOG OUT" style:UIBarButtonItemStylePlain target:self action:@selector(btnLogoutPressed:)];
    self.navigationItem.hidesBackButton = YES;

    // [self getProfileDetails];

    _btnProfilePic.layer.cornerRadius = 10; // this value vary as per your desire
    _btnProfilePic.clipsToBounds = YES;
    [_btnProfilePic.layer setBorderWidth:3.0f];
    [_btnProfilePic.layer setBorderColor:[UIColor whiteColor].CGColor];

}
//-(void)getProfileDetails{
//    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//    NSString *strParam = [NSString stringWithFormat:@"getprofile/%@",@"13"];
//    //  NSString *strParam = [NSString stringWithFormat:@"&lat=%@&long=%@&iPage=%@",@"-33.7775849",@"150.9078043",@"0"];
//    JSONParser *parser = [[JSONParser alloc]initWith_withURL:WebURL withParam:strParam withType:@"NORMAL" withSelector:@selector(getProfileResponse:) withObject:self];
//}
-(void)viewDidAppear:(BOOL)animated{

  //  [self setUserInformation];
    [self getProfileDetails];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getProfileDetails{
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];

    // [self.navigationController pushViewController:proPicVC animated:YES];
    NSLog(@"%s", __FUNCTION__);
    @try {

        NSString *strURL=[NSString stringWithFormat:@"%@getprofile/%@",WebURLAccount,[dicLogedUserInfo objectForKey:@"Id"]];
        NSURL *url = [NSURL URLWithString:strURL];
        NSMutableURLRequest* reqeust = [NSMutableURLRequest requestWithURL:url];
        NSString *strToken=[dicLogedUserInfo objectForKey:@"AuthToken"];
       // [ret setValue:@"myCookie=foobar" forHTTPHeaderField:@"Cookie"];
        [reqeust setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:reqeust delegate:self];

//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//       // [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
//      //  NSString *strToken=[dicLogedUserInfo objectForKey:@"AuthToken"];
//        [request addRequestHeader:@"Cookie" value:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken]];
//        [request setRequestMethod:@"GET"];
//        [request setDelegate:self];
//        [request startAsynchronous];

    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }
    //   }
    // Create the request.

}
-(IBAction)btnEditPressed:(id)sender{

    EditProfileViewController *editProfileVC=[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
    editProfileVC.dicProfileData=dicProfileInfo;
    [self.navigationController pushViewController:editProfileVC animated:YES];
//    FindFriendViewController *findFrndVC=[[FindFriendViewController alloc] initWithNibName:@"FindFriendViewController" bundle:nil];
//    [self.navigationController pushViewController:findFrndVC animated:YES];

}
-(IBAction)btnFriendPressed:(id)sender{

    FindFriendViewController *findFrndVC=[[FindFriendViewController alloc] initWithNibName:@"FindFriendViewController" bundle:nil];
    
    [self.navigationController pushViewController:findFrndVC animated:YES];
}
-(IBAction)btnLogoutPressed:(id)sender{
    
    UIAlertView *alertDelete=[[UIAlertView alloc] initWithTitle:APP_Name message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertDelete show];

}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSLog(@"%s", __FUNCTION__);
//   // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    @try {
//        NSString *responseString = [request responseString];
//        NSDictionary *dic = [responseString objectFromJSONString];
//        NSLog(@"dic :: %@",responseString);
//        
//        NSDictionary *dicError=[dic valueForKey:@"Error"];
//        NSString *strCode=[dicError objectForKey:@"Code"];
//        if([[dicError objectForKey:@"Code"] intValue]!=0){
//            DisplayAlert([dicError objectForKey:@"Message"]);
//        }else{
//            dicProfileInfo=[[NSMutableDictionary alloc] init];
//            dicProfileInfo=[dic objectForKey:@"Target"];
//           // [self setUserInformation:[dic objectForKey:@"Target"]];
//        }
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
//    }
//
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    NSLog(@"Failed --> %s: %@", __FUNCTION__, error);
//  //  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//
//}
-(void)setUserInformation{

    [_lblEmail setText:[appDelegate.dicUSerProfileInfo objectForKey:@"Email"]];
    [_lblFullName setText:[appDelegate.dicUSerProfileInfo objectForKey:@"FullName"]];
    
    
    if ([appDelegate.dicUSerProfileInfo objectForKey:@"Phone"] != [NSNull null]) {
          [_lblPhoneNumber setText:[appDelegate.dicUSerProfileInfo objectForKey:@"Phone"]];
    }else{
          [_lblPhoneNumber setText:@"-"];
    }
    if ([appDelegate.dicUSerProfileInfo objectForKey:@"Avatar"] != [NSNull null]) {
       
        NSArray *bytesArray = [appDelegate.dicUSerProfileInfo objectForKey:@"Avatar"] ;
        
        
        unsigned char *buffer = (unsigned char*)malloc([bytesArray count]);
        int i=0;
        for (NSDecimalNumber *num in bytesArray) {
            buffer[i++] = [num intValue];
        }
        NSData *data = [NSData dataWithBytes:buffer length:[bytesArray count]];
        free(buffer);

        [_btnProfilePic setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//        
//        unsigned c = strings.count;
//        uint8_t *bytes = malloc(sizeof(*bytes) * c);
//        
//        unsigned i;
//        for (i = 0; i < c; i++)
//        {
//            NSString *str = [strings objectAtIndex:i];
//            int byte = [str intValue];
//            bytes[i] = (uint8_t)byte;
//        }
//        
//        NSData *datos = [NSData dataWithBytes:bytes length:c];
//        UIImage *image = [UIImage imageWithData:datos];
//        [_imgViewProfilepic setImage:image];

    }

    [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];

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

    [_responseData appendData:data];
    NSString *responseString= [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
  //  NSLog(@"responseString = %@",responseString);
   dic = [responseString objectFromJSONString];
   // NSLog(@"dic :: %@",responseString);
    
    NSDictionary *dicError=[dic valueForKey:@"Error"];
    NSString *strCode=[dicError objectForKey:@"Code"];
    if([[dicError objectForKey:@"Code"] intValue]!=0){
        DisplayAlert([dicError objectForKey:@"Message"]);
    }else{
        dicProfileInfo=[[NSMutableDictionary alloc] init];
        dicProfileInfo=[dic objectForKey:@"Target"];
        NSString *strUserId=[dicProfileInfo objectForKey:@"UserID"];
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
    NSLog(@"Connection Finish ");
    appDelegate.dicUSerProfileInfo=dicProfileInfo;
    [self setUserInformation];

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
#pragma mark- alertButton Delegate Method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (IBAction)btnGroupPressed:(id)sender {
    
    GroupListViewController *groupVC=[[GroupListViewController alloc] initWithNibName:@"GroupListViewController" bundle:nil];
    [self.navigationController pushViewController:groupVC animated:YES];
    
}
@end
