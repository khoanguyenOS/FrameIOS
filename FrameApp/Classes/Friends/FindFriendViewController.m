//
//  FindFriendViewController.m
//  Frame
//
//  Created by Hardik on 8/16/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "FindFriendViewController.h"
#import "JSONKit.h"
#import "FriendCustomCell.h";
#import <QuartzCore/QuartzCore.h>

@interface FindFriendViewController ()

@end
@implementation FindFriendViewController
@synthesize aryFindFriends,aryReqFriends,tblReqFriend,tblFindFriend,tblFriend,aryFriends;
NSURLConnection *connAddFriend,*connReqFriend,*connAccpetFrnd,*connRejectFrnd,*connFrnd;

int intSegmentValue=0;
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
    self.title=@"FRIEND";
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnFindFriendPressed{

    [self getFindFriendDetails];
}
-(IBAction)btnAddFriend:(id)sender{
    
    NSLog(@"%d",[sender tag]);
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSDictionary *dicFriend=[aryFindFriends objectAtIndex:[sender tag]];
    NSString *strURL=[NSString stringWithFormat:@"%@makefriend",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    [dic setValue:[appDelegate.dicUserInfo objectForKey:@"Id"] forKey:@"userId"];
    [dic setValue:[dicFriend objectForKey:@"UserId"] forKey:@"friendId"];

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
    connAddFriend = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
}
-(IBAction)btnAcceptFriendPressed:(id)sender{
 
    NSLog(@"%d",[sender tag]);
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSDictionary *dicFriend=[aryReqFriends objectAtIndex:[sender tag]];
    NSString *strURL=[NSString stringWithFormat:@"%@acceptrequest",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:[appDelegate.dicUserInfo objectForKey:@"Id"] forKey:@"userId"];
    [dic setValue:[dicFriend objectForKey:@"FriendRequestId"] forKey:@"friendRequestId"];
    
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
    connAccpetFrnd = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
-(IBAction)btnRejectFriendPressed:(id)sender{
    NSLog(@"%d",[sender tag]);
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSDictionary *dicFriend=[aryReqFriends objectAtIndex:[sender tag]];
    NSString *strURL=[NSString stringWithFormat:@"%@ignorerequest",@"http://api.frame.com/friend/"];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:[appDelegate.dicUserInfo objectForKey:@"Id"] forKey:@"userId"];
    [dic setValue:[dicFriend objectForKey:@"FriendRequestId"] forKey:@"friendRequestId"];
    
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
    connRejectFrnd = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}
-(void)getFriendsList{
    
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
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


//Hardik
-(void)getListing{
    [_segmentFrnd selectedSegmentIndex];
}
- (void)getFindFriendDetails{
    [_txtSearch resignFirstResponder];
    if([_txtSearch.text length]>0){
    
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    // [self.navigationController pushViewController:proPicVC animated:YES];
    NSLog(@"%s", __FUNCTION__);
    @try {
                
     //   NSString *strURL=[NSString stringWithFormat:@"%@getprofile/%@",WebURL,[appDelegate.dicUserInfo objectForKey:@"Id"]];
        NSString *strURL=[NSString stringWithFormat:@"%@findfriends/%@/%@/50/0",@"http://api.frame.com/friend/",[appDelegate.dicUserInfo objectForKey:@"Id"],_txtSearch.text];
        
     //   NSString *strURL=[NSString stringWithFormat:@"%@GetFriendRequests/%@/10/0",@"http://api.frame.com/friend/",[appDelegate.dicUserInfo objectForKey:@"Id"]];
        
        NSURL *url = [NSURL URLWithString:strURL];
        
        NSMutableURLRequest* reqeust = [NSMutableURLRequest requestWithURL:url];
        NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
        reqeust.HTTPMethod = @"GET";
        // [ret setValue:@"myCookie=foobar" forHTTPHeaderField:@"Cookie"];
        [reqeust setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:reqeust delegate:self];
    
    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }
    //   }
    // Create the request.
    }
    
}
-(void)getFriendRequest{
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    // [self.navigationController pushViewController:proPicVC animated:YES];
    NSLog(@"%s", __FUNCTION__);
    @try {
        
        //   NSString *strURL=[NSString stringWithFormat:@"%@getprofile/%@",WebURL,[appDelegate.dicUserInfo objectForKey:@"Id"]];
        //NSString *strURL=[NSString stringWithFormat:@"%@findfriends/%@/%@/10/0",@"http://api.frame.com/friend/",[appDelegate.dicUserInfo objectForKey:@"Id"],_txtSearch.text];
        
          NSString *strURL=[NSString stringWithFormat:@"%@GetFriendRequests/%@/50/0",@"http://api.frame.com/friend/",[appDelegate.dicUserInfo objectForKey:@"Id"]];
        
        NSURL *url = [NSURL URLWithString:strURL];
        
        NSMutableURLRequest* reqeust = [NSMutableURLRequest requestWithURL:url];
        NSString *strToken=[appDelegate.dicUserInfo objectForKey:@"AuthToken"];
        reqeust.HTTPMethod = @"GET";

        // [ret setValue:@"myCookie=foobar" forHTTPHeaderField:@"Cookie"];
        [reqeust setValue:[NSString stringWithFormat:@"AUTH_TOKEN=%@",strToken] forHTTPHeaderField:@"Cookie"];
        // Create url connection and fire request
        connReqFriend = [[NSURLConnection alloc] initWithRequest:reqeust delegate:self];
    
    }
    @catch (NSException *exception) {
        NSLog(@"Exception --> %s: %@ : %@", __FUNCTION__, [exception name], [exception reason]);
    }
    //   }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // if([aryFindFriends count]<_totalRecords){
        
     //   return [aryFindFriends count]+1;
   // }
   // else
    if(tableView==tblFindFriend)
        return [aryFindFriends count];
    else if(tableView==tblFriend)
        return [aryFriends count];
    else
        return [aryReqFriends count];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int totlRec;
    if(theTableView==tblFindFriend)
        totlRec=[aryFindFriends count];
    else if(theTableView==tblFriend)
       totlRec= [aryFriends count];
    else
        totlRec=[aryReqFriends count];
    if(indexPath.row<totlRec){
        
        static NSString *CellIdentifier = @"Cell";
        FriendCustomCell *cell =[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            cell = [[FriendCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //    cell.imageView.image=[UIImage imageNamed:@"rejectfriend-b.png"];
        //    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
        //    cell.detailTextLabel.text=@"dfkskdfjsdj fksdfj skfj";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if(theTableView==tblFindFriend){
        NSDictionary *obj=[aryFindFriends objectAtIndex:indexPath.row];
        
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
        [cell.btnAddFriend setTag:indexPath.row];
        
        BOOL isFriend=[[obj objectForKey:@"IsFriend"] boolValue];
        if(isFriend){
            [cell.btnAddFriend setHidden:YES];
        }else{
            [cell.btnAddFriend setHidden:NO];
        }
        
        [cell.btnAddFriend addTarget:self action:@selector(btnAddFriend:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRejectFriend setHidden:YES];
        }else if(tblFriend==theTableView){
        
            {
                
                NSDictionary *obj=[aryFriends objectAtIndex:indexPath.row];
                
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
                [cell.btnAddFriend setTag:indexPath.row];
                [cell.btnRejectFriend setTag:indexPath.row];
                BOOL isFriend=[[obj objectForKey:@"IsFriend"] boolValue];
                if(isFriend){
                    [cell.btnAddFriend setHidden:YES];
                }else{
                    [cell.btnAddFriend setHidden:YES];
                }
                
                [cell.btnAddFriend addTarget:self action:@selector(btnAcceptFriendPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnRejectFriend setHidden:YES];
                [cell.btnRejectFriend addTarget:self action:@selector(btnRejectFriendPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }else{
        
            NSDictionary *obj=[aryReqFriends objectAtIndex:indexPath.row];
            
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
            [cell.btnAddFriend setTag:indexPath.row];
            [cell.btnRejectFriend setTag:indexPath.row];
            BOOL isFriend=[[obj objectForKey:@"IsFriend"] boolValue];
            if(isFriend){
                [cell.btnAddFriend setHidden:YES];
            }else{
                [cell.btnAddFriend setHidden:NO];
            }
            
            [cell.btnAddFriend addTarget:self action:@selector(btnAcceptFriendPressed:) forControlEvents:UIControlEventTouchUpInside];
             [cell.btnRejectFriend setHidden:NO];
            [cell.btnRejectFriend addTarget:self action:@selector(btnRejectFriendPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
//        cell.cellStrUserID=[obj objectForKey:@"frd_id"];
//        
//        cell.cellLblUsrName.text = [NSString stringWithFormat:@"%@ ", [obj valueForKey:@"frd_name"]];
//        cell.cellLblUsrName.font=FONT_SEGOE_UI_14;
//        cell.cellLblUsrName.textColor=UICOLOR_BACK_BTN_FONT_COLOR;
//        
//        [cell.cellImgViewUser setImageWithURL:(NSURL *)[[ obj objectForKey:@"pic"]stringByReplacingOccurrencesOfString:@"\\"withString:@"//"]];
//        [cell.cellImgViewUser.layer setBorderWidth:1];
//        [cell.cellImgViewUser.layer setBorderColor:[UICOLOR_QUESTION_BOARDER CGColor]];
//        
//        cell.cellLblUsrCountry.text = [NSString stringWithFormat:@"%@ ", [obj valueForKey:@"country"]];
//        cell.cellLblUsrCountry.font=FONT_SEGOE_UI_14;
//        cell.cellLblUsrCountry.textColor=UICOLOR_IMAGE_BORDER_COLOR_DARK;
//        
//        [cell.cellbtnAdd setHidden:NO];
//        [cell.cellbtnAdd addTarget:self action:@selector(btnAddFriendAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.cellbtnAdd setTag:indexPath.row];
//        NSMutableDictionary *dicStatusUserIcon = [Global getUserPhotoStatusMode:
//                                                  [obj valueForKey:@"friend_status"]
//                                                                          isBoy:YES
//                                                                           size:@"Big"];
//        
//        //  NSLog(@"BIG __ friend_status :: %@",[obj valueForKey:@"friend_status"]);
//        //  NSLog(@"BIG __ imageName :: %@",[dicStatusUserIcon valueForKey:@"imageName"]);
//        
//        UIImage *image = [UIImage imageNamed:[dicStatusUserIcon valueForKey:@"imageName"]];
//        [cell.cellbtnAdd setImage:image forState:UIControlStateNormal];
//        [cell.cellbtnAdd setUserInteractionEnabled:[[dicStatusUserIcon valueForKey:@"isEnable"] boolValue]];
//        
//        NSNumber  *strFriendStatus=[obj objectForKey:@"friend_status"];
//        if([strFriendStatus intValue]==3){
//            
//            UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.x, cell.frame.size.width, cell.frame.size.width)];
//            bgView.backgroundColor=UICOLOR_FRND_LIGHTBG;
//            cell.backgroundView=bgView;
//        }
        
        return cell;
    }else{
        
        return [self loadingCell];
    }
    
    return nil;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 73;

}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (cell.tag == kLoadingCellTag) {
//        _currentPageIndex=_currentPageIndex+PAGGING_COUNT;
//        
//        [self getFriendsBySearchFromServer:@"0"];
//        
//        
//    }
//}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    FriendDitalViewController *frndDtlVC=[[FriendDitalViewController alloc]initWithNibName:@"FriendDitalViewController" bundle:nil];
    //    frndDtlVC.strFriendID=[[_mArySearchFriend objectAtIndex:indexPath.row] valueForKey:@"frd_id"];
    //    NSNumber  *strFriendStatus=[[_mArySearchFriend objectAtIndex:indexPath.row] objectForKey:@"friend_status"];
    //    if([strFriendStatus intValue]==3)
    //        frndDtlVC.isFriend=YES;
    //    else
    //        frndDtlVC.isFriend=NO;
    //
    //    [self.navigationController pushViewController:frndDtlVC animated:YES];

}

- (UITableViewCell *)loadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    float x = 90.0;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame = CGRectMake(x, 5, 30, 30);
    
    UILabel *lblLoadMore = [[UILabel alloc] init];
    lblLoadMore.frame = CGRectMake(x+35, 9, 100, 20);
    lblLoadMore.text = @"Load More";
    lblLoadMore.backgroundColor = [UIColor clearColor];
   // lblLoadMore.textColor = UICOLOR_TEXTFIELD_DARK_FONT_COLOR;
  //  lblLoadMore.font = FONT_SEGOE_UI_14;
    
    [cell addSubview:activityIndicator];
    [cell addSubview:lblLoadMore];
    
    [activityIndicator startAnimating];
 //   cell.tag = kLoadingCellTag;

    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self getFindFriendDetails];
    return YES;
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
    if(connection==connAddFriend){
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
             DisplayAlert(@"Friend Request sent Successfully");
            NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:[dic objectForKey:@"Target"]];
            NSLog(@"%@",[dic objectForKey:@"FriendRequestId"]);
        }
      
    }else if(connection==connReqFriend){
    
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            aryReqFriends=[[NSMutableArray alloc] init];
            aryReqFriends=[dic objectForKey:@"Target"];
            [tblReqFriend reloadData];
        }

    }else if(connFrnd==connection){
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            aryFriends=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"Target"]];
            [self.tblFriend reloadData];
        }
        
    }else if(connection==connAccpetFrnd || connection==connRejectFrnd){
    
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        NSDictionary *dic = [responseString objectFromJSONString];
        // NSLog(@"dic :: %@",responseString);
        
        NSDictionary *dicError=[dic valueForKey:@"Error"];
        NSString *strCode=[dicError objectForKey:@"Code"];
        if([[dicError objectForKey:@"Code"] intValue]!=0){
            DisplayAlert([dicError objectForKey:@"Message"]);
        }else{
            if(connection==connAccpetFrnd){
                DisplayAlert(@"Friend Add Successfully");
            }else
                DisplayAlert(@"ignore  Successfully");
           // [tblReqFriend reloadData];
            
        }

    }else{
            
            [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
            NSDictionary *dic = [responseString objectFromJSONString];
            // NSLog(@"dic :: %@",responseString);
            
            NSDictionary *dicError=[dic valueForKey:@"Error"];
            NSString *strCode=[dicError objectForKey:@"Code"];
            if([[dicError objectForKey:@"Code"] intValue]!=0){
                DisplayAlert([dicError objectForKey:@"Message"]);
            }else{
                aryFindFriends=[[NSMutableArray alloc] init];
                aryFindFriends=[dic objectForKey:@"Target"];
                [tblFindFriend reloadData];
            }
        }
    
    }


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


- (void)viewDidUnload {
    [self setTblFindFriend:nil];
    [self setTxtSearch:nil];
    [self setSegmentFrnd:nil];
    [self setBtnSearch:nil];
    [self setTblReqFriend:nil];
    [self setTblFriend:nil];
    [super viewDidUnload];
}
- (IBAction)segValueChange:(id)sender {
    int segValue=[_segmentFrnd selectedSegmentIndex] ;
    switch (segValue) {
        case 0:
        {
            [_txtSearch setHidden:NO];
            [_btnSearch setHidden:NO];
            [tblFindFriend setHidden:NO];
            [tblReqFriend setHidden:YES];
            [tblFriend setHidden:YES];
        }
            break;
        case 1:
        {
            [_txtSearch setHidden:YES];
            [_btnSearch setHidden:YES];
            [tblFindFriend setHidden:YES];
            [tblReqFriend setHidden:NO];
            [tblFriend setHidden:YES];
            [self getFriendRequest];
            
        }
            break;
        case 2:
        {
            [_txtSearch setHidden:YES];
            [_btnSearch setHidden:YES];
            [tblFriend setHidden:NO];
            [tblFindFriend setHidden:NO];
            [tblReqFriend setHidden:NO];
            [self getFriendsList];
        }
            break;
        default:
            break;
    }
    
}
@end
