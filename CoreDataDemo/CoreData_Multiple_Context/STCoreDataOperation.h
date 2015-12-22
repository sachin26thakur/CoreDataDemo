//
//  CoreDataOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STOperation.h"
#import "STCoreDataManager.h"

#import <CoreData/CoreData.h>


typedef enum : NSUInteger {
    PARENT_CONTEXT_TYPE,
    CHILD_CONTEXT_TYPE,
    PRIVATE_CONTEXT_TYPE,
} ManageObjectContextType;


@interface STCoreDataOperation : STOperation

@property (nonatomic,strong) NSString *entityName;

- (instancetype)initWithContextType:(ManageObjectContextType)contextType andEntityName:(NSString*)entityName;

- (NSManagedObjectContext*)managedObjectContext;

- (void)saveContext:(FinishedBlock)finishBlock;

- (void)resume;

@end
