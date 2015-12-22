# CoreDataDemo
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
