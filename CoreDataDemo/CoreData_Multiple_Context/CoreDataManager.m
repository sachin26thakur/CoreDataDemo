//
//  CoreDataOperation.m
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import "CoreDataManager.h"
#import "CSVReaderOperation.h"
#import "CoreDataAddOperation.h"


static CoreDataManager * uniqueInstance;


@interface CoreDataManager ()
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong) NSOperationQueue *operationQueue;
@end


@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+(instancetype)sharedCoreDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[CoreDataManager alloc]init];
        [uniqueInstance initialize];
    });
    return uniqueInstance;
}


- (void)resumeOperation:(NSOperation*)operation{
    if (self.operationQueue == nil) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    [self.operationQueue addOperation:operation];
}



- (void)initialize{
    
    //Intialize CoreData
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






#pragma mark - Core Data Operation

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.CoreData_Multiple_Context" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData_Multiple_Context" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData_Multiple_Context.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}










@end
