//
//  RKPropertyMapping.h
//  RestKit
//
//  Created by Blake Watters on 8/27/12.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>

/**
 `RKPropertyMapping` is an abstract class for describing the properties being mapped within an `RKObjectMapping` or `RKEntityMapping` object. It defines the common interface for its concrete subclasses `RKAttributeMapping` and `RKRelationshipMapping`. Each property mapping defines a single transformation from a source key path (often in the deserialized representation of a JSON or XML document) to a destination key path (typically on a target object).
 */
@interface RKPropertyMapping : NSObject <NSCopying>

///-----------------------------------------------------
/// @name Accessing the Source and Destination Key Paths
///-----------------------------------------------------

/**
 A key path on the source object from which to get information that is to be mapped onto the destination object.
 */
@property (nonatomic, strong, readonly) NSString *sourceKeyPath;

/**
 A key path on the destination object on which to set information that has been mapped from the source object.
 */
@property (nonatomic, strong, readonly) NSString *destinationKeyPath;

///----------------------------------
/// @name Comparing Property Mappings
///----------------------------------

/**
 Compares the receiving property mapping to another property mapping.

 Two property mappings are equal if they are of the same type (i.e. an `RKAttributeMapping` or an `RKRelatiobshipMapping` object) and specify a mapping from the same source key path to the same destination key path.

 @param otherMapping The property mapping object with which to compare the receiver.
 @return `YES` if `otherMapping` specifies the same mapping as the receiver, otherwise `NO`.
 */
- (BOOL)isEqualToMapping:(RKPropertyMapping *)otherMapping;

@end
