//
//  SLFirstViewController.m
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import "SLFirstViewController.h"
#import "SLAppDelegate.h"
#import "SLEmployeeTableViewCell.h"

@interface SLFirstViewController ()
{
    SLAppDelegate   *_appDelegate;
}
@end

@implementation SLFirstViewController

- (void)viewDidLoad
{
    UIImage *pattern = [UIImage imageNamed:@"grey.png"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:pattern];

    _appDelegate = (SLAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.refreshControl addTarget:self action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:SLAPPInitialLoad object:nil];
}

- (IBAction)refresh:(id)sender
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma Mark UITableViewDataSource Required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _appDelegate.peopleManager.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SLEmployeeTableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];

    if (nil == tableViewCell) {
        tableViewCell = [[SLEmployeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"TableCell"];
    }

    tableViewCell.employee = [_appDelegate.peopleManager objectAtIndex:indexPath.row];
    
    if (indexPath.row == _appDelegate.peopleManager.count - 7) {
        dispatch_queue_t downloadqueue = dispatch_queue_create("image downloader", NULL);
        dispatch_async(downloadqueue , ^{
            [_appDelegate getMorePeople:self];
        });
    }

    return tableViewCell;
}

@end
