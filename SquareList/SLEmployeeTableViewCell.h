//
//  SLEmployeeTableViewCell.h
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLSquareEmployee.h"

@interface SLEmployeeTableViewCell : UITableViewCell {
    IBOutlet UILabel *fullName;
    IBOutlet UILabel *jobTitle;
    IBOutlet UILabel *birthDate;
    IBOutlet UILabel *tenure;
    IBOutlet UIImageView *kitteh;
}
@property (nonatomic, strong) SLSquareEmployee *employee;
@end
