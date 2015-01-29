//
//  GroupCustomCell.m
//  Frame
//
//  Created by Hardik on 9/4/13.
//  Copyright (c) 2013 openXcell. All rights reserved.
//

#import "GroupCustomCell.h"

@implementation GroupCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *nibArray=[[NSBundle mainBundle]loadNibNamed:@"GroupCustomCell" owner:self options:nil];
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
