//
//  MapViewController.h
//  Track
//
//  Created by zhe wu on 4/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController

@property(nonatomic) NSString *tracking;
@property(nonatomic) NSString *carrierText;
//@property(nonatomic) NSString *carrier;
@property (weak, nonatomic) IBOutlet UILabel *trackingLabel;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *statusData;

@end
