//
//  ViewController.h
//  CoreData_Multiple_Context
//
//  Created by Globallogic on 27/10/15.
//  Copyright (c) 2015 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "InsurenceData.h"

@interface ViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onClickSlect:(id)sender;
- (IBAction)onClickDesselect:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;

@end

