//
//  CoreDataTableViewController.h
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)performFetch;

@end
