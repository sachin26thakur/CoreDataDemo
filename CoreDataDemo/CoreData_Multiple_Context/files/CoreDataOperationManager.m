//
//  CoreDataOperation.m
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import "CoreDataOperationManager.h"
static CoreDataOperationManager * uniqueInstance;


@interface CoreDataOperationManager ()
@property (nonatomic,strong) NSOperationQueue *coreDataOperationQueue;
@end


@implementation CoreDataOperationManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;

+(instancetype)sharedCoreDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueInstance = [[CoreDataOperationManager alloc]init];
    });
    return uniqueInstance;
}
- (NSArray *)fetchAllRecords
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"InsurenceData" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"unitID" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    NSError *error;
    NSArray *objects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return objects;
    
}
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"InsurenceData" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"unitID" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];

    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail

    }
    return _fetchedResultsController;
    
    
}


-(void)deleteAllRecords
{
    NSError *error;
    NSArray *objects = [[NSArray alloc]initWithArray:[self fetchAllRecords]];
    for (InsurenceData *record in objects)
    {
        
        [_managedObjectContext deleteObject:record];
        
    }
    [_managedObjectContext save:&error];
}

-(void)removeRecordFromContextWithUnitID:(NSNumber*)recordID
{
    NSString *iD=[NSString stringWithFormat:@"%@",recordID];
    NSArray *objects = [[NSArray alloc]initWithArray:[self fetchAllRecords]];
    for (InsurenceData *record in objects)
    {
        if (record.unitID==iD)
        {
            [_managedObjectContext deleteObject:record];
        }
    }
    [self saveContext];
}



-(InsurenceData*)getRecordsAtIndex:(NSIndexPath*)index{
    NSArray *allrecords=[[NSArray alloc]init];
    allrecords=[NSArray arrayWithArray:[self fetchAllRecords]];
    if (allrecords.count>0) {
        return [allrecords objectAtIndex:index.row];
    }else
    return nil;
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
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support



-(BOOL)isRecordAlreadyPresentInContext:(NSString*)iD andArray:(NSArray*)arr{
    BOOL foundItem = NO;

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"InsurenceData"];
    request.predicate = [NSPredicate predicateWithFormat:@"unitID == %@", iD];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"unitID" ascending:YES]];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (results.count>0) {
        foundItem = YES;
    }
    
    return foundItem;
}

#pragma mark - fetch Operation


#pragma mark - save Operation

-(void)addRecordToContextAtIndex:(NSUInteger)index andData:(NSDictionary*)dict
{
    InsurenceData *record = [NSEntityDescription insertNewObjectForEntityForName:@"InsurenceData" inManagedObjectContext:self.managedObjectContext];
    record.unitID=[dict objectForKey:@"Unit_id"];
    record.instName=[dict objectForKey:@"instName"];
    record.address=[dict objectForKey:@"address"];
    record.city= [dict objectForKey:@"city"];
    record.zipCode=[dict objectForKey:@"zipCode"];
    record.chiefName=[dict objectForKey:@"chiefName"];
    record.webAddress=[dict objectForKey:@"webAddress"];
    [[CoreDataOperationManager sharedCoreDataManager]
     saveContext];
}


- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //[managedObjectContext save:&error];
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
