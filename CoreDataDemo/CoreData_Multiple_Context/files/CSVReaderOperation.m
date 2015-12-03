//
//  CSVReader.m
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 28/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import "CSVReaderOperation.h"

#define ID_INDEX  0
#define INST_NAME_INDEX  1
#define ADDRESS_INDEX 2
#define CITY_INDEX 3
#define ZIP_INDEX 4
#define CHIEF_INDEX 8
#define WEB_ADDRESS_INDEX 15

@interface CSVReaderOperation ()
@property (nonatomic,strong) NSString *csvFilePath;
@end


@implementation CSVReaderOperation


- (instancetype)initWithCSVFilePath:(NSString*)filePath{
    self = [super init];
    self.csvFilePath = filePath;
    return self;
}


- (void)main{
    NSError *error = nil;
    NSString *fileDataString=[NSString stringWithContentsOfFile:_csvFilePath encoding:NSASCIIStringEncoding error:&error];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    self.finishBlock([self formattedArray:linesArray],error);
}



-(NSArray*)formattedArray:(NSArray*)linesArray{
   
    NSMutableArray *formattedArray = [NSMutableArray array];
    
    [linesArray enumerateObjectsUsingBlock:^(NSString* lineString, NSUInteger idx, BOOL *stop) {

        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        if (columnArray.count>15) {
            [dictionary setObject:[columnArray objectAtIndex:ID_INDEX] forKey:@"Unit_id"];
            [dictionary setObject:[columnArray objectAtIndex:INST_NAME_INDEX] forKey:@"instName"];
            
            [dictionary setObject:[columnArray objectAtIndex:ADDRESS_INDEX] forKey:@"address"];
            [dictionary setObject:[columnArray objectAtIndex:CITY_INDEX] forKey:@"city"];
            [dictionary setObject:[columnArray objectAtIndex:ZIP_INDEX] forKey:@"zipCode"];
            [dictionary setObject:[columnArray objectAtIndex:CHIEF_INDEX] forKey:@"chiefName"];
            [dictionary setObject:[columnArray objectAtIndex:WEB_ADDRESS_INDEX] forKey:@"webAddress"];
            [formattedArray addObject:dictionary];
        }
        
    }];

    return formattedArray;

}
@end
