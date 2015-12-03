//
//  CoreDataOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STOperation.h"
#import "CoreDataManager.h"

#import <CoreData/CoreData.h>


typedef enum : NSUInteger {
    PARENT_CONTEXT_TYPE,
    CHILD_CONTEXT_TYPE,
    PRIVATE_CONTEXT_TYPE,
} ManageObjectContextType;


@interface CoreDataOperation : STOperation
- (instancetype)initWithContextType:(ManageObjectContextType)contextType;
- (NSManagedObjectContext*)managedObjectContext;
-(BOOL)isRecordAlreadyExist:(NSString*)Id;
- (void)saveContext:(FinishedBlock)finishBlock;



@end
