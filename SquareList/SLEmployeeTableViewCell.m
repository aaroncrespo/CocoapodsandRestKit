//
//  SLEmployeeTableViewCell.m
//  SquareList
//
//  Created by aaron crespo on 9/26/12.
//  Copyright (c) 2012 aaroncrespo. All rights reserved.
//

#import "SLEmployeeTableViewCell.h"
#import <CoreImage/CoreImage.h>
#import <OpenGLES/EAGL.h>


//After enabling this performance dragged while drawing images. so I used a few tweeks to get some quick performance.
@implementation UIImage(Sepia)
- (UIImage*)sepia
{
    CIImage *startImage = [CIImage imageWithCGImage:[self CGImage]];
    EAGLContext *myEAGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    //ignore color space for performance
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject: [NSNull null] forKey: kCIContextWorkingColorSpace];
    
    //hw accelerate it, for more performance decrease context creation.
    CIContext *context = [CIContext contextWithEAGLContext:myEAGLContext options:options];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, startImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
        
    CGImageRelease(cgimg);
    return newImg;
}
@end

@interface SLEmployeeTableViewCell()

@end

@implementation SLEmployeeTableViewCell

@synthesize employee = _employee;
- (void)setEmployee:(SLSquareEmployee *)employee
{
    if (employee && employee != self.employee) {
        _employee = employee;
        [self setupFields];
        [self getKitteh];
    }
}

- (void)getKitteh
{
    //create some fuzzy thumbnail picture sizes since requests to 60/60 will return the same kitteh
    NSString *kittehString = [NSString stringWithFormat:@"http://placekitten.com/6%d/6%d", arc4random() % 9, arc4random() % 9];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kittehString]];

    //get an image and draw on mainthread
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error){
                               if (error) {
                                   NSLog(@"Failed with error: %@", [error localizedDescription]);
                               } else {
                                   UIImage *sepiakittehImage = [[UIImage imageWithData:data] sepia];
                                   kitteh.image = sepiakittehImage;
                                   
                               }
                               
                           }];
}

- (void)setupFields
{
    fullName.text   = self.employee.fullName;
    jobTitle.text   = self.employee.jobTitle;
    birthDate.text  = [NSDateFormatter localizedStringFromDate:self.employee.birthDate dateStyle:NSDateFormatterMediumStyle timeStyle:0];
    [self setupTenure];
    
}

- (void)setupTenure
{
    NSDate *epoc = [[NSDate alloc] init];
    NSDate *tenureDate = [[NSDate alloc] initWithTimeInterval:self.employee.tenure sinceDate:epoc];
    
    unsigned int unitFlags = NSMonthCalendarUnit | NSYearCalendarUnit;
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:epoc  toDate:tenureDate  options:0];
    
    NSMutableString *tenureText = [@"" mutableCopy];

    if (breakdownInfo.year) { 
        (breakdownInfo.year > 1) ? [tenureText appendFormat:@"%d years ", breakdownInfo.year] : [tenureText appendString:@"1 year "];
    }
    
    if (breakdownInfo.month == 1) {
        [tenureText appendString:@"1 month"];
    } else {
        [tenureText appendFormat:@"%d months",breakdownInfo.month];
    }
    
    tenure.text     = tenureText;
}
@end
