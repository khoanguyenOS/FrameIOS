//
//  AppDelegate.h
//  FrameApp
//
//  Created by Hardik on 8/5/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate:UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
//Reachability
@property(nonatomic,assign)int InternetConnectionFlag;
-(void)reachabilityChanged:(NSNotification*)note;


@property(strong,nonatomic) NSMutableDictionary *dicUserInfo;
@property(strong,nonatomic)NSMutableDictionary *dicUSerProfileInfo;
@end
