//
//  TrackInfo+CoreDataProperties.m
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TrackInfo+CoreDataProperties.h"

@implementation TrackInfo (CoreDataProperties)

@dynamic carrier;
@dynamic eta;
@dynamic tracking_number;
@dynamic addressFrom;
@dynamic addressTo;
@dynamic serviceLevel;
@dynamic trackingHistory;
@dynamic trackingStatus;

@end
