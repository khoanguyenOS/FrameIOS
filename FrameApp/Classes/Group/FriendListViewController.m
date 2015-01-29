//
//  FriendListViewController.m
//  Frame
//
//  Created by Hardik on 9/4/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "FriendListViewController.h"
#import "JSONKit.h"

#import "FriendCustomCell.h"

#import <QuartzCore/QuartzCore.h>

@interface FriendListViewController ()

@end

@implementation FriendListViewController
@synthesize aryFriends;
NSURLConnection *connFrnd;
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
        self.title=@"FRIENDS";
     UIColor *color=[UIColor colorWithRed:8.0/256.0 green:157.0/256.0 blue:233.0/256.0 alpha:1];
    [_lblBGFriends setBackgroundColor:color];
    [self getFriendsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTblFriendList:nil];
    [self setLblBGFriends:nil];
    [super viewDidUnload];
}
-(void)getFriendsList{

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strURL=[NSString stringWithFormat:@"%@getallfriends/%@/%@/%@",@"http://api.frame.com/friend/",[appDelegate.dicUserInfo objectForKey:@"Id"],@"100",@"0"];
        NSURL *url = [NSURL URLWithString:strURL];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
        // Create url connection and fire request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // Specify that it will be a POST request
        request.HTTPMethod = @"GET";
        // This is how we set header fields
        [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
        // Convert your data and set your request's HTTPBody property
        NSError *error;
        //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
      //  NSData *jsonData=[dic JSONData];
       // [request setHTTPBody:jsonData];
        connFrnd = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if([aryFindFriends count]<_totalRecords){
    
    //   return [aryFindFriends count]+1;
    // }
    return [aryFriends count];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int totlRec;
    totlRec=[aryFriends count];
    if(indexPath.row<totlRec){
        
        static NSString *CellIdentifier = @"Cell";
        FriendCustomCell *cell =[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[FriendCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //    cell.imageView.image=[UIImage imageNamed:@"rejectfriend-b.png"];
        //    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
        //    cell.detailTextLabel.text=@"dfkskdfjsdj fksdfj skfj";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        int intRowIndex=indexPath.row;
        
        NSDictionary *obj=[aryFriends objectAtIndex:intRowIndex];
        
        [cell.lblName setText:[obj objectForKey:@"FullName"]];
        cell.imgProfilePic.layer.cornerRadius = 10; // this value vary as per your desire
        cell.imgProfilePic.clipsToBounds = YES;
        [cell.imgProfilePic.layer setBorderWidth:3.0f];
        [cell.imgProfilePic.layer setBorderColor:[UIColor yellowColor].CGColor];
        if ([obj objectForKey:@"Avatar"] != [NSNull null]) {
            NSArray *bytesArray = [obj objectForKey:@"Avatar"] ;
            unsigned char *buffer = (unsigned char*)malloc([bytesArray count]);
            int i=0;
            for (NSDecimalNumber *num in bytesArray) {
                buffer[i++] = [num intValue];
            }
            NSData *data = [NSData dataWithBytes:buffer length:[bytesArray count]];
            free(buffer);
            [cell.imgProfilePic setImage:[UIImage imageWithData:data] ];
        }
        [cell.btnAddFriend setTag:intRowIndex];
        [cell.btnRejectFriend setTag:intRowIndex];
        BOOL isFriend=[[obj objectForKey:@"IsFriend"] boolValue];
        if(isFriend){
            [cell.btnAddFriend setHidden:YES];
        }else{
            [cell.btnAddFriend setHidden:NO];
        }
        
        //[cell.btnAddFriend addTarget:self action:@selector(btnAcceptFriendPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRejectFriend setHidden:YES];
        
      //  [cell.btnRejectFriend addTarget:self action:@selector(btnRemoveToGroupPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        
        // return [self loadingCell];
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 73;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    int intRowIndex=indexPath.row;
    
    NSDictionary *obj=[aryFriends objectAtIndex:intRowIndex];
    

    if([self.delegate respondsToSelector:@selector(picFriendsDidFinish:)]) {
        [self.delegate picFriendsDidFinish:obj];
    }

    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    //    dic = [responseString objectFromJSONString];
    //    // NSLog(@"dic :: %@",responseString);
    //
    //    NSDictionary *dicError=[dic valueForKey:@"Error"];
    //    NSString *strCode=[dicError objectForKey:@"Code"];
    //    if([[dicError objectForKey:@"Code"] intValue]!=0){
    //        DisplayAlert([dicError objectForKey:@"Message"]);
    //    }else{
    //        dicProfileInfo=[[NSMutableDictionary alloc] init];
    //        dicProfileInfo=[dic objectForKey:@"Target"];
    //
    //    }
  
    
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
    //    appDelegate.dicUSerProfileInfo=dicProfileInfo;
    //    [self setUserInformation];
    NSString *responseString= [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSLog(@"responseString = %@",responseString);
    
    
    //    if(connection==connCreateGroup){
    //        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
    //        NSDictionary *dic = [responseString objectFromJSONString];
    //        // NSLog(@"dic :: %@",responseString);
    //
    //        NSDictionary *dicError=[dic valueForKey:@"Error"];
    //        NSString *strCode=[dicError objectForKey:@"Code"];
    //        if([[dicError objectForKey:@"Code"] intValue]!=0){
    //            DisplayAlert([dicError objectForKey:@"Message"]);
    //        }else{
    //
    //            NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:[dic objectForKey:@"Target"]];
    //            NSLog(@"%@",[dic objectForKey:@"GroupId"]);
    //            [self getGroupList];
    //
    //        }
    //    }else
    if(connFrnd==connection){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            aryFriends=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"Target"]];
            [self.tblFriendList reloadData];
        }
        
    }
    else{
        
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            
            NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:[dic objectForKey:@"Target"]];
            NSLog(@"%@",[dic objectForKey:@"GroupId"]);
            
            
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (IBAction)btnClosePressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
