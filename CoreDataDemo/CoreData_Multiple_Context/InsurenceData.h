//
//  InsurenceData.h
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface InsurenceData : NSManagedObject

@property (nonatomic, retain) NSString * unitID;
@property (nonatomic, retain) NSString * instName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * zipCode;
@property (nonatomic, retain) NSString * chiefName;
@property (nonatomic, retain) NSString * webAddress;

@end
