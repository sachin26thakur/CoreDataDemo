//
//  CoreDataOperation.h
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "InsurenceData.h"

@interface CoreDataOperationManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

+(instancetype)sharedCoreDataManager;
- (NSArray *)fetchAllRecords;
-(void)deleteAllRecords;
-(void)removeRecordFromContextWithUnitID:(NSNumber*)recordID;
-(InsurenceData*)getRecordsAtIndex:(NSIndexPath*)index;
-(void)addRecordToContextAtIndex:(NSUInteger)index andData:(NSDictionary*)dict;
-(BOOL)isRecordAlreadyPresentInContext:(NSString*)iD andArray:(NSArray*)arr;
@end
