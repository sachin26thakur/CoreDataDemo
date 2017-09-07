# Multi Context Core Data Example
#Description: This helper clases motivates to use multiple NSManagedObjectContext as follows:

- Save operation core data use  either parent context or child context based on your need.
- Fetch opearation on core data use either parent context or child context based on your need
- This are all operation done with the help of blocks so you will get call back after each opeartion is completed.
- this opeation execute on background thread, no worry of iOS app UI reponsive.
-  d

# Usage
 -  To change file name of core data, go to STCoreDataManager class and replace value from CORE_DATA_FILENAME your file name.
 ```sh
      extern NSString *const CORE_DATA_FILENAME;
 ```
 
 -  To insert data in to persistent store, and fetch opearation follow this:
 ```sh
    NSDictionary *userDict = @{@"uniqueID":@"1234",@"name":@"sachin"};
        STCoreDataAddOperation *insertOperation = [[STCoreDataAddOperation alloc] initWithContextType:CHILD_CONTEXT_TYPE EntityName:@"EntityName" and:userDict];
    [insertOperation setFinishedBlock:^(id obj, NSError *error) {
    NSLog(@"Added sucessfully");
    }];
    [insertOperation resume];

```

  
NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    
    //Fetch Operation
    STCoreDataFetchOperation *fetchOperation = [[STCoreDataFetchOperation alloc] initWithContextType:PARENT_CONTEXT_TYPE Predicate:nil andSortDescriptor:sort forEntityName:STTestDataEntity];
    
    
    [fetchOperation setFinishedBlock:^(id obj, NSError *error) {
        self.fetchResultController = (NSFetchedResultsController*)obj;
        self.fetchResultController.delegate = self;
        [self.tableView reloadData];
    }];
    
    [fetchOperation resume];
    
   ```
