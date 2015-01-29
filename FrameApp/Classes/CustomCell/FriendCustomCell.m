//
//  FriendCustomCell.m
//  Frame
//
//  Created by Hardik on 8/16/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "FriendCustomCell.h"

@implementation FriendCustomCell
@synthesize btnAddFriend,lblName,imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
            NSArray *nibArray=[[NSBundle mainBundle]loadNibNamed:@"FriendCustomCell" owner:self options:nil];
            self=[nibArray objectAtIndex:0];
        }
    return self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
