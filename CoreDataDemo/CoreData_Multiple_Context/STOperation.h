//
//  STOperation.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 01/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishedBlock)(id obj, NSError *error);

@interface STOperation : NSOperation

@property (nonatomic,copy) FinishedBlock finishBlock;
- (void)setFinishedBlock:(FinishedBlock)finishBlock;
@end
