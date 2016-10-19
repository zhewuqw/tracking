//
//  Tracking_history+CoreDataProperties.h
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tracking_history.h"
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tracking_history (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *object_created;
@property (nullable, nonatomic, retain) NSString *object_id;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *status_details;
@property (nullable, nonatomic, retain) NSDate *status_date;
@property (nullable, nonatomic, retain) NSSet<Location *> *trackingHistoryLocation;

@end

@interface Tracking_history (CoreDataGeneratedAccessors)

- (void)addTrackingHistoryLocationObject:(Location *)value;
- (void)removeTrackingHistoryLocationObject:(Location *)value;
- (void)addTrackingHistoryLocation:(NSSet<Location *> *)values;
- (void)removeTrackingHistoryLocation:(NSSet<Location *> *)values;

@end

NS_ASSUME_NONNULL_END
