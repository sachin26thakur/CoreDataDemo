//
//  STOperation.m
//  CoreData_Multiple_Context
//
//  Created by Sachin on 01/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import "STOperation.h"

@interface STOperation ()



@end

@implementation STOperation

- (void)setFinishedBlock:(FinishedBlock)finishBlock{
    self.finishBlock = finishBlock;
}

@end
