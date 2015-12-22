//
//  CoreDataAddOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STCoreDataAddOperation.h"
#import "STTestData.h"




@interface STCoreDataAddOperation ()
//this data is use to save in persistent store.
@property (nonatomic,strong) id data;
@end


@implementation STCoreDataAddOperation

- (instancetype)initWithContextType:(ManageObjectContextType)contextType EntityName:(NSString*)entityName and:(id)data{
    self = [super initWithContextType:contextType andEntityName:entityName];
    self.data = data;
    self.entityName = entityName;
    return self;
}


-(void)addRecord
{
    STTestData *record = (STTestData*)[NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:[self managedObjectContext]];
    
    [record setupInputData:_data];
    
    [self saveContext:self.finishBlock];
}


- (void)main{
    [self addRecord];
}




@end
