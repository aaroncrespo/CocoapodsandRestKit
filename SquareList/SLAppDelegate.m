//
//  SLAppDelegate.m
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import <RestKit/RestKit.h>


#import "SLAppDelegate.h"
#import "SLSquareEmployee.h"

NSString * const SLAPPInitialLoad = @"com.square.networking.operation.finish";

@implementation SLAppDelegate

@synthesize peopleManager = _peopleManager;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.peopleManager = [@[] mutableCopy];
    [self getMorePeople:self];
    return YES;
}

- (IBAction)getMorePeople:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //shoots off an async nsoperation to pull some people from twitter
    //SLSquareEmployee is a Twitter user See SLSquareEmployee.h or json mapping for property breakdown    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[SLSquareEmployee mapping]
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        [self.peopleManager addObjectsFromArray:[result array]];
        [[NSNotificationCenter defaultCenter] postNotificationName:SLAPPInitialLoad object:self];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
    
    [operation start];
}
@end
