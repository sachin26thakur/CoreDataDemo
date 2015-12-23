//
//  CoreDataAddOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STOperation.h"
#import "STCoreDataOperation.h"



@interface STCoreDataAddOperation : STCoreDataOperation

/**
 *  This method intialize STCoreDataAddOperation object, for saving data in to
 *  persistent store
 *
 *  @param Here are two options for choosing context type, If want to perform operation
 *  on parent context use "PRIVATE_CONTEXT_TYPE" otherwise use "CHILD_CONTEXT_TYPE"
 *  @param this takes NSString object as name of NSManagedObject entity
 *  @param this would be type of nsdictionary that containing key value objects
 *
 *  @return STCoreDataAddOperation object
 */
- (instancetype)initWithContextType:(ManageObjectContextType)contextType EntityName:(NSString*)entityName and:(id)data;
@end
