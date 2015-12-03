//
//  CoreDataAddOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 02/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "CoreDataAddOperation.h"
#import "InsurenceData.h"

@interface CoreDataAddOperation ()
//this data is use to save in persistent store.
@property (nonatomic,strong) id data;
@end


@implementation CoreDataAddOperation



- (instancetype)initWithContextType:(ManageObjectContextType)contextType and:(id)toAddObject{
    self = [super initWithContextType:contextType];
    self.data = toAddObject;
    return self;
}


-(void)addRecord:(id)data
{
    InsurenceData *record = [NSEntityDescription insertNewObjectForEntityForName:@"InsurenceData" inManagedObjectContext:[self managedObjectContext]];
    record.unitID=[data objectForKey:@"Unit_id"];
    record.instName=[data objectForKey:@"instName"];
    record.address=[data objectForKey:@"address"];
    record.city= [data objectForKey:@"city"];
    record.zipCode=[data objectForKey:@"zipCode"];
    record.chiefName=[data objectForKey:@"chiefName"];
    record.webAddress=[data objectForKey:@"webAddress"];
    [self saveContext:self.finishBlock];
    if (self.isFinished) {
        NSLog(@"is finished");
    }
}


- (void)main{
    if ([self isRecordAlreadyExist:[self.data objectForKey:@"Unit_id"]]) {
        self.finishBlock(nil,[NSError errorWithDomain:@"Data is already exist in memory" code:000 userInfo:nil]);
    }else{
        [self addRecord:self.data];       
    }
    
}




@end
