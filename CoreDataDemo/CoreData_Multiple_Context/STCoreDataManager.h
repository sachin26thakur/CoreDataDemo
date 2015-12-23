//
//  CoreDataOperation.h
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STTestData.h"



#define STTestDataEntity @"STTestData"


/**
 *  Please change name of core data file name as your need
 */
extern NSString *const CORE_DATA_FILENAME;




@interface STCoreDataManager : NSObject
/**
 *  this is parent NSManagedObjectContext object context, it will always perform operation on main thread
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**
 *  This single method always return unique instance
 *  of CoreDataManager, this object responsible for
 *  initialzing NSPersistentStoreCoordinator object and NSManagedObjectModel object
 *  and as well as NSManagedObjectContext object
 *  @return Unique instance of CoreDataManager
 */
+(instancetype)sharedCoreDataManager;

/**
 *  This method add NSOperation object in to 
 *  NSOperationQueue object and resume operation
 *
 *  @param operation provide NSOperation object to be execute
 */
- (void)resumeOperation:(NSOperation*)operation;


@end
