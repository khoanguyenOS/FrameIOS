//
//  JSONParser.h
//  DemoNotification
//
//  Created by Dhaval on 3/5/13.
//  Copyright (c) 2013 i-phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject<NSURLConnectionDelegate>
{
    SEL mySelector;
    NSString *strReqType;
    NSObject *Object;
}
@property(nonatomic,strong)NSMutableData *webData;
@property(nonatomic,strong)NSURLConnection *connection;
-(id)initWith_withURL:(NSString *)strURL withParam:(NSString *)params withType:(NSString *)type withSelector:(SEL)sel withObject:(NSObject *)objectReceive;

@end
