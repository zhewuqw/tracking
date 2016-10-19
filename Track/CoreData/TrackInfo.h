//
//  TrackInfo.h
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address_to, Service_level, Tracking_history, Tracking_status;

NS_ASSUME_NONNULL_BEGIN

@interface TrackInfo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "TrackInfo+CoreDataProperties.h"
