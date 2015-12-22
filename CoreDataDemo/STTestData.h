//
//  STTestData.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 22/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface STTestData : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (void)setupInputData:(id)data;


@end

NS_ASSUME_NONNULL_END

#import "STTestData+CoreDataProperties.h"
