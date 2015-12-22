//
//  STTestData.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 22/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STTestData.h"

@implementation STTestData

// Insert code here to add functionality to your managed object subclass

- (void)setupInputData:(id)data{
    self.uniqueID = [data objectForKey:@"uniqueID"];
    self.name = [data objectForKey:@"name"];
}

@end
