//
//  STTestData+CoreDataProperties.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 22/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "STTestData.h"

NS_ASSUME_NONNULL_BEGIN

@interface STTestData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *uniqueID;

@end

NS_ASSUME_NONNULL_END
