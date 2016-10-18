//
//  TrackingModel.h
//  Track
//
//  Created by zhe wu on 10/6/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackingModel : NSObject

/** image of delivery status */
@property (nonatomic, strong)UIImage  *deliveryStatusImage;

/** Label of tracking number */
@property (nonatomic, strong) NSString *trackingNumLabel;

/** Label of delivery detail */
@property (nonatomic, strong) NSString *deliveryDetailLabel;

/** Label of delivery date */
@property (nonatomic, strong) NSString *deliveryDateLabel;

@end
