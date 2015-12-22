//
//  CoreDataFetchOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STCoreDataOperation.h"


@interface STCoreDataFetchOperation : STCoreDataOperation



- (instancetype)initWithContextType:(ManageObjectContextType)contextType Predicate:(NSPredicate*)predicate andSortDescriptor:(NSSortDescriptor*)sortDescriptor forEntityName:(NSString*)entityName;


@end
