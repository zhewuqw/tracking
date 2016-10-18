//
//  CoreDataStack.h
//  Track
//
//  Created by zhe wu on 10/17/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//- (void)initializeCoreData;
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;
//
////插入数据
//- (void)insertCoreData:(NSMutableArray*)dataArray;
////查询
//- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
////删除
//- (void)deleteData;
////更新
//- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
