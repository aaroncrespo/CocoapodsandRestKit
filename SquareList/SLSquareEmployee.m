//
//  SLPerson.m
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import "SLSquareEmployee.h"
#import <RestKit/ObjectMapping.h>

@implementation SLSquareEmployee

@synthesize screenName    = _username;
@synthesize fullName    = _fullName;
@synthesize birthDay    = _birthDay;
@synthesize tenure      = _tenure;
@synthesize jobTitle    = _jobTitle;

#pragma Mark Getter Overrides
- (NSString *)jobTitle
{
    return self.screenName;
}

- (NSTimeInterval) tenure
{
    return ([[NSDate date] timeIntervalSinceDate:[self birthDate]]);
}
            
- (NSDate *)birthDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE LLL dd HH:mm:ss Z yyyy"];
    NSDate *myDate = [formatter dateFromString: self.birthDay];
    return myDate;
}

#pragma Mark Restkit json to object mapping
+ (RKObjectMapping *)mapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
         @"user.name":          @"fullName",
         @"user.screen_name":   @"screenName",
         @"user.created_at":    @"birthDay"
     }];
    
    return mapping;
}
@end
