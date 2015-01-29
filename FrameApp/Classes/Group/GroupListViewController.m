//
//  GroupListViewController.m
//  Frame
//
//  Created by Hardik on 8/26/13.
//  Copyright (c) 2013 openXcell. All rights reserved.

#import "GroupListViewController.h"
#import "GroupListViewController.h"
#import "JSONKit.h"

#import "GroupCustomCell.h"

#import <QuartzCore/QuartzCore.h>
#import "GroupDetailViewController.h"
@interface GroupListViewController ()

@end
@implementation GroupListViewController
@synthesize tblGroupList,aryGroup;

NSURLConnection *connCreateGroup,*connFrndAddToGroup,*connGroupList;
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
    self.title=@"GROUP";
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                              UIBarButtonSystemItemAdd target:self action:@selector(btnAddNewGroupPressed:)];
    [self getGroupList];

}
-(void)getGroupList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strURL=[NSString stringWithFormat:@"%@getgroups",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
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
    connGroupList = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
-(IBAction)btnAddNewGroupPressed:(id)sender{
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:APP_Name  message:@"Please enter group name." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];
    
}
-(void)getCreateGroupReqeust:(NSString*)strGroupName{
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSString *strURL=[NSString stringWithFormat:@"%@creategroup",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:[appDelegate.dicUserInfo objectForKey:@"Id"] forKey:@"UserId"];
    [dic setValue:strGroupName forKey:@"GroupName"];
    
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
    connCreateGroup = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//-(IBAction)btnAddInGroupPressed:(id)sender{
//    NSLog(@"%d",[sender tag]);
//    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//
//    NSString *strURL=[NSString stringWithFormat:@"%@addfriendtogroup",@"http://api.frame.com/friend/"];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//
//    [dic setValue:@"276" forKey:@"UserId"];
//    [dic setValue:@"95" forKey:@"GroupId"];
//
//    NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
//    // Create url connection and fire request
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    // Specify that it will be a POST request
//    request.HTTPMethod = @"POST";
//    // This is how we set header fields
//    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
//    // Convert your data and set your request's HTTPBody property
//    NSError *error;
//    //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//    NSData *jsonData=[dic JSONData];
//    [request setHTTPBody:jsonData];
//    connFrndAddToGroup = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//
//}
//-(IBAction)btnRemoveToGroupPressed:(id)sender{
//    NSLog(@"%d",[sender tag]);
//    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//    
//    NSString *strURL=[NSString stringWithFormat:@"%@removefriendoutgroup",@"http://api.frame.com/friend/"];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    
//    [dic setValue:@"4" forKey:@"GroupMemberId"];
//  
//    
//    NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
//    // Create url connection and fire request
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    // Specify that it will be a POST request
//    request.HTTPMethod = @"POST";
//    // This is how we set header fields
//    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
//    // Convert your data and set your request's HTTPBody property
//    NSError *error;
//    //NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//    NSData *jsonData=[dic JSONData];
//    [request setHTTPBody:jsonData];
//    connFrndAddToGroup = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if([aryFindFriends count]<_totalRecords){
    
    //   return [aryFindFriends count]+1;
    // }
    return [aryGroup count];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int totlRec;
        totlRec=[aryGroup count];
    if(indexPath.row<totlRec){
        
        static NSString *CellIdentifier = @"Cell";
        GroupCustomCell *cell =[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[GroupCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //    cell.imageView.image=[UIImage imageNamed:@"rejectfriend-b.png"];
        //    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
        //    cell.detailTextLabel.text=@"dfkskdfjsdj fksdfj skfj";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        

            
            NSDictionary *obj=[aryGroup objectAtIndex:indexPath.row];
            
            [cell.lblName setText:[obj objectForKey:@"Name"]];
            [cell.btnRight setTag:indexPath.row];
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController *groudDetailVC=[[GroupDetailViewController alloc]initWithNibName:@"GroupDetailViewController" bundle:nil];
    groudDetailVC.strSelectedGroupID=[[aryGroup objectAtIndex:indexPath.row] objectForKey:@"GroupId"];
    groudDetailVC.title=[[aryGroup objectAtIndex:indexPath.row] objectForKey:@"Name"];
    [self.navigationController pushViewController:groudDetailVC animated:YES];
    
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

    
    if(connection==connCreateGroup){
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
            [self getGroupList];
            
        }
    }else if(connGroupList==connection){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            aryGroup=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"Target"]];
            [self.tblGroupList reloadData];
        }
      
    }
    else{
        {
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
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark- UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        if([[[alertView textFieldAtIndex:0] text] length]>0){
            [self getCreateGroupReqeust:[[alertView textFieldAtIndex:0] text]];
        
        }  else{
            
        }
    }
    
}
- (void)viewDidUnload {
    [self setTblGroupList:nil];
    [super viewDidUnload];
}
@end
