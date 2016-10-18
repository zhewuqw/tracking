//
//  TrackingTableViewCell.m
//  Track
//
//  Created by zhe wu on 10/6/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "TrackingTableViewCell.h"

@implementation TrackingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTrack:(TrackingModel *)track
{
    _track = track;
    self.track.deliveryStatusImage = [UIImage imageNamed:@"checkMark"];
    self.track.deliveryDetailLabel = @"123";
    self.track.deliveryDetailLabel = @"djdjlksdfjksf";
    self.track.deliveryDateLabel = @"2016=123";
}

@end
