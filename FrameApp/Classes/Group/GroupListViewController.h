//
//  GroupListViewController.h
//  Frame
//
//  Created by Hardik on 8/26/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblGroupList;

@property(strong,nonatomic)NSMutableData *responseData;
@property(strong,nonatomic)NSMutableArray *aryGroup;

@end
