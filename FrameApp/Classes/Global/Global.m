//
//  Global.m
//  Hammer
//
//  Created by Bhavesh on 12/8/12.
//  Copyright (c) 2012 Bhavesh Dhaduk. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (NSString *) stringFromDate:(NSDate *)dt
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
   // [dateFormat setDateFormat:@"MM/dd/yyyy"];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:dt];

    return dateString;
}
+(NSString *) stringFromDateForComment:(NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm a"];

    return [NSString stringWithFormat:@"%@ at %@",[dateFormat stringFromDate:date],[timeFormat stringFromDate:date]];
}
+(NSString *) stringFromDateForFriends:(NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"dd,MMMM yyyy"];
    return [dateFormat stringFromDate:date];
}
+ (BOOL)isStringBlank:(NSString *)str
{
    if([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return TRUE;
    }
    return FALSE;
    
}
+ (BOOL) validateEmail: (NSString *) email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

+ (void) alertView_OK:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: title
                          message: msg
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
 
}

+ (NSString *) removeWhiteSpace:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//Hardik
+(NSDate *)dateFromString:(NSString *)strDate{
    NSDateFormatter* fmt = [NSDateFormatter new];
   [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[fmt setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [fmt dateFromString:strDate];
    return date;
    
}
+ (NSMutableDictionary *) getUserPhotoStatusMode :(NSString *)friendStatus isBoy:(BOOL)isBoy size:(NSString *)size {
    
    //    4 types of friends available
    
    //    0 - Add friend
    //    1 - Accept Friend
    //    2 - Friend Request sent
    //    3 - Friend
    //    4 - Posted By Logged In User
    
    
    
    
    int intIndex = [friendStatus integerValue];
    
    NSMutableString *imgName = [[NSMutableString alloc] init];
    BOOL isEnable = FALSE;
    
    
    if (intIndex == 0)
    {
        [imgName appendString:@"StatusAddFriend"];
        isEnable = TRUE;
    }
    else if (intIndex == 1)
    {
        [imgName appendString:@"StatusFriend"];
        //        [imgName appendString:@"StatusAcceptFriend"];
        isEnable = FALSE;
    }
    else if (intIndex == 2)
    {
        [imgName appendString:@"StatusFriendRequestSent"];
        isEnable = FALSE;
    }
    else if (intIndex == 3)
    {
        [imgName appendString:@"StatusFriend"];
        isEnable = FALSE;
    }
    
    else if (intIndex == 4)
    {
        [imgName appendString:@"PostedByLoggedInUser"];
        isEnable = FALSE;
    }
    
    if (isBoy == TRUE) {
        [imgName appendFormat:@"_Boy_%@",size];
    }
    else{
        [imgName appendFormat:@"_Girl_%@",size];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:imgName forKey:@"imageName"];
    [dic setObject:[NSNumber numberWithBool:isEnable] forKey:@"isEnable"];
    

    imgName = nil;
    
    return dic;
}


@end
