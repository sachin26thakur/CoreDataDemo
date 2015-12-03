//
//  STAppManager.h
//  CoreData_Multiple_Context
//
//  Created by Sachin on 01/12/15.
//  Copyright © 2015 Globallogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STAppManager : NSObject

+(instancetype)sharedCoreDataManager;

@property (nonatomic,strong) NSOperationQueue *operationQueue;
@end
