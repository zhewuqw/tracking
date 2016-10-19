//
//  Service_level+CoreDataProperties.h
//  Track
//
//  Created by zhe wu on 10/19/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Service_level.h"

NS_ASSUME_NONNULL_BEGIN

@interface Service_level (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
