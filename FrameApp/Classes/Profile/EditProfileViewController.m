//
//  EditProfileViewController.m
//  FrameApp
//
//  Created by Hardik on 8/12/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "EditProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize imgUserPic;
BOOL isProfileUpdate;
NSURLConnection *connUploadImage;
NSMutableDictionary *dicResponse;
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
    
     self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(btnDonePressed:)];
    self.title=@"EDIT PROFILE";
    
    _btnProfileImg.layer.cornerRadius = 10; // this value vary as per your desire
    _btnProfileImg.clipsToBounds = YES;
    [_btnProfileImg.layer setBorderWidth:3.0f];
    [_btnProfileImg.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self SetData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnDonePressed:(id)sender{
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:_txtPhone.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (valid){ // Not numeric
        
    self.navigationItem.leftBarButtonItem.enabled=NO;
    self.navigationItem.backBarButtonItem.enabled=NO;
    
    [_txtFullName resignFirstResponder];
    [_txtPhone resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSString *strURL=[NSString stringWithFormat:@"%@updateprofile",WebURLAccount];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:_txtFullName.text forKey:@"FullName"];
    [dic setValue:_txtPhone.text forKey:@"Phone"];
    [dic setValue:[_dicProfileData objectForKey:@"UserId"] forKey:@"UserId"];

    NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
    // Create url connection and fire request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    // This is how we set header fields
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
    // Convert your data and set your request's HTTPBody property

    NSError *error;
    //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSData *jsonData=[dic JSONData];
    [request setHTTPBody:jsonData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else{
        DisplayAlert(@"Please enter valid phone number.");
    }
}

- (void)imgageUpload {
    
    // [self.navigationController pushViewController:proPicVC animated:YES];
    NSLog(@"%s", __FUNCTION__);
    @try {
        
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSURL *url = [NSURL URLWithString:@"http://api.frame.com/account/updateavatar"];
        NSData *data=UIImagePNGRepresentation(imgUserPic);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
        // Create the request.
        NSMutableURLRequest *requestAvatar = [NSMutableURLRequest requestWithURL:url];
        
        // Specify that it will be a POST request
        requestAvatar.HTTPMethod = @"POST";
        // This is how we set header fields
        [requestAvatar setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [requestAvatar setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
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
        
        [dic setValue:[appDelegate.dicUserInfo objectForKey:@"Id"] forKey:@"UserId"];
        [dic setValue:byteArray forKey:@"Avatar"];
        NSData *d=[dic JSONData];
        requestAvatar.HTTPBody = d;
        
        // Create url connection and fire request
       connUploadImage = [[NSURLConnection alloc] initWithRequest:requestAvatar delegate:self];
        
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
-(void)SetData{

    [_txtFullName setText:[_dicProfileData objectForKey:@"FullName"]];
    if ([_dicProfileData objectForKey:@"Phone"] != [NSNull null]) {
        [_txtPhone setText:[_dicProfileData objectForKey:@"Phone"]];
    }
    if ([_dicProfileData objectForKey:@"Avatar"] != [NSNull null]) {
            
            NSArray *bytesArray = [_dicProfileData objectForKey:@"Avatar"] ;
            
            
            unsigned char *buffer = (unsigned char*)malloc([bytesArray count]);
            int i=0;
            for (NSDecimalNumber *num in bytesArray) {
                buffer[i++] = [num intValue];
            }
            NSData *data = [NSData dataWithBytes:buffer length:[bytesArray count]];
            free(buffer);
            
            [_btnProfileImg setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];

            
        }
        
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
    dicResponse = [responseString objectFromJSONString];
  //  NSLog(@"dic :: %@",responseString);

    NSDictionary *dicError=[dicResponse valueForKey:@"Error"];
    NSString *strCode=[dicError objectForKey:@"Code"];
    if([[dicError objectForKey:@"Code"] intValue]!=0){
        if([[dicError objectForKey:@"Message"] length]>0)
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

    if(connection==connUploadImage){
            appDelegate.dicUSerProfileInfo=[dicResponse objectForKey:@"Target"];
        self.navigationItem.leftBarButtonItem.enabled=YES;
        self.navigationItem.backBarButtonItem.enabled=YES;
            [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
    }else{
        if(isProfileUpdate){
            [self imgageUpload];
        }else{
            //without Image
            appDelegate.dicUSerProfileInfo=[dicResponse objectForKey:@"Target"];
            self.navigationItem.leftBarButtonItem.enabled=YES;
            self.navigationItem.backBarButtonItem.enabled=YES;
          [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
       
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

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
    [_btnProfileImg setImage:imgUserPic forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_btnProfileImg setImage:imgUserPic forState:UIControlStateNormal];
    [_btnProfileImg setImage:imgUserPic forState:UIControlStateNormal];
    isProfileUpdate=YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField==_txtFullName)
        [_txtPhone becomeFirstResponder];
    else{
        [textField resignFirstResponder];
     }
    return YES;
}
//- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//   
//    if(textField==_txtPhone){
//    NSUInteger oldLength = [textField.text length];
//    NSUInteger replacementLength = [string length];
//    NSUInteger rangeLength = range.length;
//    
//    NSUInteger newLength = oldLength - rangeLength + replacementLength;
//    
//    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
//    
//    return newLength <= 10 || returnKey;
//    }else{
//        return YES;
//    }
//
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    if(textField==_txtPhone){
    // allow backspace
    if (!string.length)
    {
        return YES;
    }
    
    // remove invalid characters from input, if keyboard is numberpad
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
    {
        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
        {
            // BasicAlert(@"", @"This field accepts only numeric entries.");
            
            return NO;
        }
    }
    
    // verify max length has not been exceeded
    NSUInteger newLength = textField.text.length + string.length - range.length;
    
    BOOL withinMaxLengthLimit = (newLength <= 10);
    
    if (!withinMaxLengthLimit)
    {
        // suppress the max length message only when the user is typing
        // easy: pasted data has a length greater than 1; who copy/pastes one character?
        if (string.length > 1)
        {
            // BasicAlert(@"", @"This field accepts a maximum of 4 characters.");
        }
        
        return NO;
    }
    
    // only enable the OK/submit button if they have entered all numbers for the last four of their SSN (prevents early submissions/trips to authentication server)
      return YES;
    }else{
        return YES;
    }
}
#pragma mark- alertButton Delegate Method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    

}
@end
