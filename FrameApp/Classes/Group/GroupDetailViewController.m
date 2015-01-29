//
//  GroupDetailViewController.m
//  Frame
//
//  Created by Hardik on 8/29/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "JSONKit.h"

#import "GroupCustomCell.h"

#import <QuartzCore/QuartzCore.h>
#import "FriendListViewController.h"

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController
@synthesize tblGroupFriendList,aryGroupFriends;
@synthesize strSelectedGroupID;
NSURLConnection *connGroupFriends,*connFrndAddToGroup,*connFrndRemoveToGroup;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                              UIBarButtonSystemItemAdd target:self action:@selector(btnAddMemberPressed:)];
    [self getGroupFriendList];
}
-(void)getGroupFriendList{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strURL=[NSString stringWithFormat:@"%@getgroupmembers",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  
    [dic setValue:strSelectedGroupID forKey:@"GroupId"];
    [dic setValue:@"0" forKey:@"PageIndex"];
    [dic setValue:@"100" forKey:@"PageSize"];
    
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
    connGroupFriends = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
-(void)getRemoveFriendResponse:(int)intTag{
  
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    NSMutableDictionary *dicGroupMember=[[NSMutableDictionary alloc]initWithDictionary:[aryGroupFriends objectAtIndex:intTag]];
    NSString *strURL=[NSString stringWithFormat:@"%@removefriendoutgroup",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:[dicGroupMember objectForKey:@"GroupMemberId"] forKey:@"GroupMemberId"];
    
    
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
    connFrndRemoveToGroup = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

}
-(IBAction)btnRemoveToGroupPressed:(id)sender{
    
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:APP_Name  message:@"Are you sure want to Remove?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [av show];
    [av setTag:[sender tag]];
    
   }
-(IBAction)btnAddMemberPressed:(id)sender{
    FriendListViewController *frndListVC=[[FriendListViewController alloc]initWithNibName:@"FriendListViewController" bundle:nil];
    frndListVC.delegate=self;
    [self presentViewController:frndListVC animated:YES completion:nil];
   //[self.navigationController pushViewController:frndListVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addFriendMemberInGroup:(NSDictionary*)dicFriend{

    NSMutableDictionary *dicFriendData=[[NSMutableDictionary alloc] initWithDictionary:dicFriend];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *strURL=[NSString stringWithFormat:@"%@addfriendtogroup",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSString  *strFriendId =[dicFriendData objectForKey:@"UserId"];
    [dic setValue:strFriendId forKey:@"UserId"];
   // [dic setValue:@"95" forKey:@"GroupId"];
    [dic setValue:strSelectedGroupID forKey:@"GroupId"];
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
    connFrndAddToGroup = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
#pragma mark Custom Delegate
- (void)picFriendsDidFinish:(NSDictionary*)dicSectedFrnd{
    [self addFriendMemberInGroup:dicSectedFrnd];
    
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if([aryFindFriends count]<_totalRecords){
    
    //   return [aryFindFriends count]+1;
    // }
    return [aryGroupFriends count];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int totlRec;
    totlRec=[aryGroupFriends count];
    if(indexPath.row<totlRec){
        
        static NSString *CellIdentifier = @"Cell";
        GroupCustomCell *cell =[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[GroupCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //    cell.imageView.image=[UIImage imageNamed:@"rejectfriend-b.png"];
        //    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
        //    cell.detailTextLabel.text=@"dfkskdfjsdj fksdfj skfj";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        int intRowIndex=indexPath.row;
        
        NSDictionary *obj=[aryGroupFriends objectAtIndex:intRowIndex];
        
        [cell.lblName setText:[obj objectForKey:@"UserName"]];
        [cell.btnRight setTag:intRowIndex];
                
         [cell.btnRight addTarget:self action:@selector(btnRemoveToGroupPressed:) forControlEvents:UIControlEventTouchUpInside];
        
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
    if(connGroupFriends==connection){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            aryGroupFriends=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"Target"]];
            [self.tblGroupFriendList reloadData];
        }
        
    }else if(connection==connFrndAddToGroup){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:[dic objectForKey:@"Target"]];
            NSLog(@"%@",[dic objectForKey:@"GroupId"]);
            DisplayAlert(@"Friend Add Sucessfully");
            [self getGroupFriendList];
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
            [self getGroupFriendList];
            
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark- UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self getRemoveFriendResponse:[alertView tag]];
      
    }
    
}

@end
