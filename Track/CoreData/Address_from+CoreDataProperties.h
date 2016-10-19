//
//  Address_from+CoreDataProperties.h
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address_from.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address_from (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSNumber *zip;

@end

NS_ASSUME_NONNULL_END
