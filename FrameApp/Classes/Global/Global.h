


#import <Foundation/Foundation.h>

typedef enum {
    SingleOpinion = 1,
    CompareOpinion,
} SelectedViewCompareOrSingle;


@interface Global : NSObject

+ (NSString *) stringFromDate:(NSDate *)dt;
+ (BOOL)isStringBlank:(NSString *)str;
+ (BOOL) validateEmail: (NSString *) email;
+ (void) alertView_OK:(NSString *)title message:(NSString *)msg;
+ (NSString *) removeWhiteSpace:(NSString *)str;

//Hardik
+(NSDate *) dateFromString:(NSString *)strDate;
+(NSString *) stringFromDateForComment:(NSDate *)date;
+(NSString *) stringFromDateForFriends:(NSDate *)date;
+ (NSMutableDictionary *) getUserPhotoStatusMode :(NSString *)friendStatus isBoy:(BOOL)isBoy size:(NSString *)size ;
@end
