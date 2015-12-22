//
//  CoreDataOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STCoreDataOperation.h"



@interface STCoreDataOperation ()

@property (nonatomic,strong) NSManagedObjectContext *childManagedObjectContext;

@property (nonatomic,assign) ManageObjectContextType contextType;




@end

@implementation STCoreDataOperation


- (instancetype)initWithContextType:(ManageObjectContextType)contextType andEntityName:(NSString*)entityName{
    self = [super init];
    _contextType = contextType;
    _entityName = entityName;
    return self;
}


- (NSManagedObjectContext*)managedObjectContext{
    
    if (_contextType == CHILD_CONTEXT_TYPE) {
        if (_childManagedObjectContext) {
            return _childManagedObjectContext ;
        }
        NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        temporaryContext.parentContext = [[STCoreDataManager sharedCoreDataManager] managedObjectContext];
        self.childManagedObjectContext = temporaryContext;
        return temporaryContext;
    }
    return [[STCoreDataManager sharedCoreDataManager] managedObjectContext];
}


- (void)saveContext:(FinishedBlock)finishBlock{
    
    __block NSError *error = nil;
    
    if (_contextType == CHILD_CONTEXT_TYPE ) {
        [_childManagedObjectContext performBlock:^{
            [_childManagedObjectContext save:&error];
            NSManagedObjectContext *parent = [[STCoreDataManager sharedCoreDataManager] managedObjectContext];
            [parent performBlock:^{
                [parent save:&error];
                finishBlock(nil,error);
            }];
            
        }];
    }else{
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        finishBlock(nil,error);
    }
    
}



- (void)resume{
    [[STCoreDataManager sharedCoreDataManager] resumeOperation:self];
}




@end
