//
//  Track+CoreDataProperties.h
//  Track
//
//  Created by zhe wu on 10/17/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Track.h"

NS_ASSUME_NONNULL_BEGIN

@interface Track (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *trackingData;

@end

NS_ASSUME_NONNULL_END
