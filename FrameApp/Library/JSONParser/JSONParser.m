//
//  JSONParser.m
//  DemoNotification
//
//  Created by Dhaval on 3/5/13.
//  Copyright (c) 2013 i-phone. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser
@synthesize webData,connection;
-(id)initWith_withURL:(NSString *)strURL withParam:(NSString *)params withType:(NSString *)type withSelector:(SEL)sel withObject:(NSObject *)objectReceive
{
    if (connection==Nil)
    {
        Object = objectReceive;
        mySelector = sel;
        self.webData = [[NSMutableData alloc]init];
        
        if ([type isEqualToString:@"POST"] || [type isEqualToString:@"GET"])
        {
            NSMutableData *postData = [NSMutableData data];
            [postData appendData: [[[NSString stringWithFormat:@"%@",params]stringByAddingPercentEscapesUsingEncoding :NSUTF8StringEncoding] dataUsingEncoding: NSUTF8StringEncoding]];
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:[NSURL URLWithString:strURL]];
            if ([type isEqualToString:@"POST"])
            {
                [urlRequest setHTTPMethod:@"POST"];
            }
            else
            {
                [urlRequest setHTTPMethod:@"GET"];
            }
            
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setHTTPBody:postData];
            
            NSString *temp = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
  
            //Start Connection
            self.connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        }
        else{
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]init];
            NSString *strReq = [NSString stringWithFormat:@"%@%@",strURL,params];
            NSLog(@"Req=%@",strReq);
            [urlRequest setURL:[NSURL URLWithString:[strReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
         
            self.connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        }
    }

    return self;

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"Error > %@",error.description);
    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:APP_Name message:@"Connection Fail" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.webData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.webData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.connection = nil;
    NSError *err;
    id objectChecker = [NSJSONSerialization JSONObjectWithData:self.webData options:NSJSONReadingMutableLeaves error:&err];
   
    if ([objectChecker isKindOfClass:[NSArray class]])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [Object performSelector:mySelector withObject:objectChecker];
#pragma clang diagnostic pop
    }
    else if([objectChecker isKindOfClass:[NSDictionary class]])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [Object performSelector:mySelector withObject:objectChecker];
#pragma clang diagnostic pop
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [Object performSelector:mySelector withObject:objectChecker];
#pragma clang diagnostic pop
    }
}
@end
