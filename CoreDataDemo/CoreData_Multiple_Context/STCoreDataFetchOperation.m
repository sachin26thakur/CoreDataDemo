//
//  CoreDataFetchOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STCoreDataFetchOperation.h"


@interface STCoreDataFetchOperation ()

@property (nonatomic,strong) NSSortDescriptor *sortDescriptor;
@property (nonatomic,strong) NSPredicate *predicate;


@end

@implementation STCoreDataFetchOperation


- (instancetype)initWithContextType:(ManageObjectContextType)contextType Predicate:(NSPredicate*)predicate andSortDescriptor:(NSSortDescriptor*)sortDescriptor forEntityName:(NSString*)entityName{
    self = [super initWithContextType:contextType andEntityName:entityName];
    _sortDescriptor = sortDescriptor;
    _predicate = predicate;
    return self;
}

- (void)main {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:self.entityName inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:self.sortDescriptor]];
    
    [fetchRequest setFetchBatchSize:20];
    
    
    if (_predicate) {
        [fetchRequest setPredicate:_predicate];
    }
    
    
     NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    
    NSError *error = nil;
    [fetchedResultsController performFetch:&error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    self.finishBlock(fetchedResultsController,error);
    });
    
}


@end


















