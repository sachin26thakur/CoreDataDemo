
//  ViewController.m
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "CSVReaderOperation.h"

#import "CoreDataFetchOperation.h"
#import "CoreDataAddOperation.h"


@interface ViewController ()
{

    NSArray *allRecords;
    NSMutableArray *selectedRecordsIndexpath;
    NSMutableArray  *selectedRecordsID;
    BOOL keepGoing;
    NSTimer *timer;
}


@property (strong, nonatomic)  NSFetchedResultsController *fetchResultController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.naviBar.backgroundColor=[UIColor blackColor];
    selectedRecordsIndexpath = [[NSMutableArray alloc]init];
    selectedRecordsID = [[NSMutableArray alloc]init];
    
    
    //Fetch Operation
    
    CoreDataFetchOperation *fetchOperation = [[CoreDataFetchOperation alloc] initWithContextType:PARENT_CONTEXT_TYPE];
    
    [fetchOperation setFinishedBlock:^(id obj, NSError *error) {
        self.fetchResultController = (NSFetchedResultsController*)obj;
        self.fetchResultController.delegate = self;
        [self.tableView reloadData];
    }];
    
    [[CoreDataManager sharedCoreDataManager] resumeOperation:fetchOperation];
    
    
    
    //Add opeation
    
    
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


- (BOOL)isSelectedRow:(NSString*)iD{
    return [selectedRecordsID containsObject:iD];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    InsurenceData *obj=[self.fetchResultController objectAtIndexPath:indexPath];
    cell.textLabel.text=obj.chiefName;

    
    if([self isSelectedRow:obj.unitID]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
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
    
    
    
//    NSArray *visibleRows = [self.tableView indexPathsForVisibleRows];
//    
//   
//    for (NSIndexPath *idx in visibleRows) {
//    
//        InsurenceData *obj=nil;
//        
//        if ([self isSelectedRow:obj.unitID]) {
//            continue;
//        }
//        
//
//        [selectedRecordsID addObject:obj.unitID];
//        
//        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:idx];
//        if(cell.accessoryType==UITableViewCellAccessoryNone)
//        {
//           cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        
//    }
}

- (IBAction)onClickDesselect:(id)sender {
    
//    NSArray *visibleRows = [self.tableView indexPathsForVisibleRows];
//    
//    for (NSIndexPath *idx in visibleRows)
//    {
//        
//        
//    
//        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:idx];
//        InsurenceData *obj=nil;
//        if ([selectedRecordsID containsObject:obj.unitID])
//        {
//            
//            if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
//            {
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            }
//            [selectedRecordsID removeObject:obj.unitID];
//            
//        }
//        
//        
//    }
    
}

@end
