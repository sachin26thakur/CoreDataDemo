//
//  CoreDataFetchOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "CoreDataFetchOperation.h"


@interface CoreDataFetchOperation ()


@end

@implementation CoreDataFetchOperation

- (void)main {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"InsurenceData" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"unitID" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
     NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    
    NSError *error = nil;
    [fetchedResultsController performFetch:&error];
    self.finishBlock(fetchedResultsController,error);
}


@end
