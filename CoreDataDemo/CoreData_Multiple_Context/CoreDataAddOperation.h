//
//  CoreDataAddOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STOperation.h"
#import "CoreDataOperation.h"



@interface CoreDataAddOperation : CoreDataOperation
- (instancetype)initWithContextType:(ManageObjectContextType)contextType and:(id)toAddObject;

@end
