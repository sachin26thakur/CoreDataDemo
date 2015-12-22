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
- (instancetype)initWithContextType:(ManageObjectContextType)contextType EntityName:(NSString*)entityName and:(id)data;
@end
