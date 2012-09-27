//
//  SLPerson.h
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    SLSquareEmployee is a Twitter user from the public timeline.
    Object property: Twitter attribute
    fullName:   name
    jobTitle:   screen_name
    birthDay:   twitter user created_at
    tenure:     created_at - time_now
*/
@class RKObjectMapping;

@interface SLSquareEmployee : NSObject

@property (nonatomic, copy) NSString    *screenName;

@property (nonatomic, copy) NSString    *fullName;
@property (nonatomic, copy) NSString    *jobTitle;

@property (nonatomic, copy) NSString    *birthDay;

@property (nonatomic) NSTimeInterval    tenure;

+ (RKObjectMapping *)mapping;
- (NSDate *)birthDate;
@end
