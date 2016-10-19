//
//  TrackInfo+CoreDataProperties.h
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TrackInfo.h"
#import "Address_from.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *carrier;
@property (nullable, nonatomic, retain) NSDate *eta;
@property (nullable, nonatomic, retain) NSString *tracking_number;
@property (nullable, nonatomic, retain) Address_from *addressFrom;
@property (nullable, nonatomic, retain) Address_to *addressTo;
@property (nullable, nonatomic, retain) Service_level *serviceLevel;
@property (nullable, nonatomic, retain) Tracking_history *trackingHistory;
@property (nullable, nonatomic, retain) Tracking_status *trackingStatus;

@end

NS_ASSUME_NONNULL_END
