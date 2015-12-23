//
//  CoreDataFetchOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STCoreDataOperation.h"


@interface STCoreDataFetchOperation : STCoreDataOperation


/**
 *  This method is use to intialize STCoreDataFetchOperation object for performing
 *  fetch opearation .
 *
 *  @param Here are two options for choosing context type, If want to perform operation
 *  on parent context use "PRIVATE_CONTEXT_TYPE" otherwise use "CHILD_CONTEXT_TYPE"
 *  @param predicate      NSPredicate type object pass to find filtered objects from
 *  persistent coordinator
 *  @param sortDescriptor NSSortDescriptor type of object to pass sorted objects from fetched objects
 *  @param entityName     NSString type of object to pass for which type of entity objects want to fetch
 *
 *  @return STCoreDataFetchOperation object.
 */
- (instancetype)initWithContextType:(ManageObjectContextType)contextType Predicate:(NSPredicate*)predicate andSortDescriptor:(NSSortDescriptor*)sortDescriptor forEntityName:(NSString*)entityName;


@end
