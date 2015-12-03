//
//  CSVReader.h
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 28/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"
#import "STOperation.h"


@interface CSVReaderOperation : STOperation

- (instancetype)initWithCSVFilePath:(NSString*)filePath;

@end


