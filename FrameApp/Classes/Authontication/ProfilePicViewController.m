//
//  ProfilePicViewController.m
//  FrameApp
//
//  Created by Hardik on 8/6/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "ProfilePicViewController.h"

#import "ProfileViewController.h"
#import "JSONKit.h"
@interface ProfilePicViewController ()

@end

@implementation ProfilePicViewController
@synthesize dicUserInfo,imgUserPic;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDonePressed:(id)sender {
   
    // [self.navigationController pushViewController:proPicVC animated:YES];
    NSLog(@"%s", __FUNCTION__);
    @try {

        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSURL *url = [NSURL URLWithString:@"http://api.frame.com/account/updateavatar"];
        NSData *data=UIImagePNGRepresentation(imgUserPic);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

        NSString *strToken=[dicUserInfo objectForKey:@"AuthToken"];
        // Create the request.
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        // This is how we set header fields
        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
        // Convert your data and set your request's HTTPBody property
        
        //NSData *requestData = [NSData dataWithBytes:[[dic JSONS] UTF8String] length:[jsonRequest length]];
        NSError *error;

        const unsigned char *bytes = [data bytes]; // no need to copy the data
        NSUInteger length = [data length];
        NSMutableArray *byteArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < length; i++) {
            [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
        }

//        NSDictionary *dictJson = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  byteArray, @"photo",
//                                  nil];
        //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
//        NSUInteger len = data.length;
//        uint8_t *bytes=(uint8_t)[data bytes];
//        uint8_t *bytes = (uint8_t *)[data bytes];
//        
//        NSMutableString *result = [NSMutableString stringWithCapacity:len * 3];
//        [result appendString:@"["];
//        for (NSUInteger i = 0; i < len; i++) {
//            if (i) {
//                [result appendString:@","];
//            }
//            [result appendFormat:@"%d", bytes[i]];
//        }
//        [result appendString:@"]"];

        NSUInteger len = [data length];
     //   Byte *byteData = (Byte*)malloc(len);
     //   memcpy(byteData, [data bytes], len);
     //   free(byteData);
        
        [dic setValue:[dicUserInfo objectForKey:@"Id"] forKey:@"UserId"];
        [dic setValue:byteArray forKey:@"Avatar"];
        NSData *d=[dic JSONData];
        request.HTTPBody = d;

        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

//        ASIFormDataRequest *requestt = [ASIFormDataRequest requestWithURL:url];
//        [requestt addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
//        NSString *strAuthToken=[dicUserInfo objectForKey:@"AuthToken"];
//       // [request addRequestHeader:@"“AUTH_TOKEN" value:strAuthToken];
//        [requestt setRequestMethod:@"POST"];
//        [requestt setDelegate:self];
//        NSData *datat=[dic JSONData];
//        [requestt appendPostData:datat];
//    //    [requestt startAsynchronous];
        dic = nil;

    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }
    //   }

}
- (IBAction)btnProfilePicPressed:(id)sender {

    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // imagePicker.mediaTypes = @[(NSString *) kUTTypeImage,(NSString *) kUTTypeMovie];
    imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker  animated:YES completion:nil];

}

//
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    NSLog(@"%s", __FUNCTION__);
//    
//    @try {
//        NSString *responseString = [request responseString];
//        NSDictionary *dic = [responseString objectFromJSONString];
//     
//      
//        NSLog(@"%@",dic);
//        
//        NSDictionary *dicError=[dic valueForKey:@"Error"];
//        if([[dicError objectForKey:@"Code"] intValue]!=0){
//            DisplayAlert([dicError objectForKey:@"Message"]);
//        }else{
//            NSMutableDictionary *dicTraget=[appDelegate.dicUserInfo objectForKey:@"Target"];
//            ProfileViewController *profileVC=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
//            profileVC.dicLogedUserInfo=dicTraget;
//            [self.navigationController pushViewController:profileVC animated:YES];
//         
//            
//        }
//
//    
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
//}

//Tells the delegate that the user picked an image. (Deprecated in iOS 3.0. Use imagePickerController:didFinishPickingMediaWithInfo: instead.)

#pragma mark imagePicker Delegate
//Tells the delegate that the user cancelled the pick operation.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
        //  self.imgUserPhoto=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *selectedImage=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        imgUserPic=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        [_btnProfilePic setImage:imgUserPic forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [_btnProfilePic setImage:imgUserPic forState:UIControlStateNormal];
        
       
        [_btnProfilePic setImage:imgUserPic forState:UIControlStateNormal];
    
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
   // NSLog(@"responseString = %@",responseString);
    NSDictionary *dic = [responseString objectFromJSONString];
   // NSLog(@"dic :: %@",responseString);
    
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
}

@end
