//
//  CoreDataOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "CoreDataOperation.h"



@interface CoreDataOperation ()

@property (nonatomic,strong) NSManagedObjectContext *childManagedObjectContext;

@property (nonatomic,assign) ManageObjectContextType contextType;


@end

@implementation CoreDataOperation


- (instancetype)initWithContextType:(ManageObjectContextType)contextType{
    self = [super init];
    self.contextType = contextType;
    return self;
}


- (NSManagedObjectContext*)managedObjectContext{
    
    if (_contextType == CHILD_CONTEXT_TYPE) {
        if (_childManagedObjectContext) {
            return _childManagedObjectContext ;
        }
        NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        temporaryContext.parentContext = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
        self.childManagedObjectContext = temporaryContext;
        return temporaryContext;
    }
    return [[CoreDataManager sharedCoreDataManager] managedObjectContext];
}

- (BOOL)isRecordAlreadyExist:(NSString*)Id{
    BOOL foundItem = NO;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"InsurenceData"];
    request.predicate = [NSPredicate predicateWithFormat:@"unitID == %@", Id];
    NSArray *results = [[self managedObjectContext] executeFetchRequest:request error:nil];
    
    if (results.count>0) {
        foundItem = YES;
    }
    return foundItem;
}


- (void)saveContext:(FinishedBlock)finishBlock{
    
    __block NSError *error = nil;
    
    if (_contextType == PARENT_CONTEXT_TYPE ) {
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        finishBlock(nil,error);
    }else
        [_childManagedObjectContext performBlock:^{
            [_childManagedObjectContext save:&error];
            NSManagedObjectContext *parent = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
            [parent performBlock:^{
                [parent save:&error];
                finishBlock(nil,error);
            }];
            
        }];
    }






@end
