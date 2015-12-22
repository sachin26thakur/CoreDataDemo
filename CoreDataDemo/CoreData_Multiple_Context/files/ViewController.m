
//  ViewController.m
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import "ViewController.h"
#import "STCoreDataManager.h"
#import "STCoreDataFetchOperation.h"
#import "STCoreDataAddOperation.h"





@interface ViewController ()
{
}


@property (strong, nonatomic)  NSFetchedResultsController *fetchResultController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.naviBar.backgroundColor=[UIColor blackColor];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    
    
    //Fetch Operation
    STCoreDataFetchOperation *fetchOperation = [[STCoreDataFetchOperation alloc] initWithContextType:PARENT_CONTEXT_TYPE Predicate:nil andSortDescriptor:sort forEntityName:STTestDataEntity];
    
    
    [fetchOperation setFinishedBlock:^(id obj, NSError *error) {
        self.fetchResultController = (NSFetchedResultsController*)obj;
        self.fetchResultController.delegate = self;
        [self.tableView reloadData];
    }];
    
    [[STCoreDataManager sharedCoreDataManager] resumeOperation:fetchOperation];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    id  sectionInfo = [[self.fetchResultController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    STTestData *obj=[self.fetchResultController objectAtIndexPath:indexPath];
    cell.textLabel.text=obj.name;
    
    return cell;
}

#pragma mark - NFetchedResultsController delegate method

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{   UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:{
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
            
        case NSFetchedResultsChangeDelete:{
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
            
        case NSFetchedResultsChangeUpdate:{
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
            
        case NSFetchedResultsChangeMove:{
            NSLog(@"No use right now");
                    }
            break;
    }
}

- (IBAction)onClickSlect:(id)sender {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Item" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (alertController)
        {
            UITextField *idTextField = alertController.textFields.firstObject;
            UITextField *nameTextField = alertController.textFields.lastObject;
            NSDictionary *userDict = @{@"uniqueID":idTextField.text,@"name":nameTextField.text};
            STCoreDataAddOperation *insertOperation = [[STCoreDataAddOperation alloc] initWithContextType:CHILD_CONTEXT_TYPE EntityName:STTestDataEntity and:userDict];
            [insertOperation resume];
            [insertOperation setFinishedBlock:^(id obj, NSError *error) {
                NSLog(@"Added sucessfully");
            }];
        }
        
    }];
    
    [alertController addAction:alertAction];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = [NSString stringWithFormat:@"%d",[[self.fetchResultController fetchedObjects] count]];
         textField.userInteractionEnabled = NO;
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"name";
     }];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
