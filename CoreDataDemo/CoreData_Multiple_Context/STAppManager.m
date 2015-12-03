//
//  STAppManager.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 01/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STAppManager.h"
#import "CSVReaderOperation.h"
#import "CoreDataAddOperation.h"



static STAppManager * uniqueInstance;


@interface STAppManager ()


@end

@implementation STAppManager


+(instancetype)sharedCoreDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[STAppManager alloc]init];
    });
    return uniqueInstance;
}


- (id)init{
    self = [super init];
    [self initialize];
    return self;
}


- (void)initialize{
    
    //Intialize CoreData
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    NSString *csvPath = [[NSBundle mainBundle] pathForResource:@"sampleRecords" ofType:@"csv"];
    ;

    //read data from csv reader
    CSVReaderOperation *csvReaderOperation = [[CSVReaderOperation alloc] initWithCSVFilePath:csvPath];
    [csvReaderOperation setFinishedBlock:^(id obj, NSError *error) {
        if (error == nil) {
            [self addRecordInDataBase:obj index:0];
        }
    }];
    
    [self.operationQueue addOperation:csvReaderOperation];
}


- (void)addRecordInDataBase:(NSArray*)dataArray index:(NSInteger)index{
    if (index>=[dataArray count]) {
        return;
    }
    NSDictionary *dict = [dataArray objectAtIndex:index++];
    CoreDataAddOperation *coreDataAddOperation = [[CoreDataAddOperation alloc] initWithContextType:CHILD_CONTEXT_TYPE and:dict];
    
    [coreDataAddOperation setFinishedBlock:^(id obj, NSError *error) {
        [self addRecordInDataBase:dataArray index:index];
    }];
    
    [self.operationQueue addOperation:coreDataAddOperation];
}






@end
