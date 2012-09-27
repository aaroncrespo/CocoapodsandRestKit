//
//  SLAppDelegate.h
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SLAPPInitialLoad;

@interface SLAppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet NSMutableArray *peopleManager;

- (IBAction)getMorePeople:(id)sender;
@end
