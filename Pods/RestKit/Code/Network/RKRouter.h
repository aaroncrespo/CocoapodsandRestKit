//
//  RKRouter.h
//  RestKit
//
//  Created by Blake Watters on 6/20/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
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

#import "RKHTTPUtilities.h"

@class RKRouteSet;

/**
 An `RKRouter` instance is responsible for generating `NSURL` objects with a given base URL and a route set. It is used to centralize the knowledge about the URL's that are used by the application.

 ## Route Generation
 
 URL's can be generated by the router in three ways:
 
 1. **By name**. Named routes link a symbolic name with a path and an HTTP request method. (see `URLForRouteNamed:method:object:`)
 2. **By object**. Routes can be defined by class and HTTP request method. When a URL is requested from the router for an object, the router will identify the most appropriate route for the object and instantiate an `NSURL` with the route's path pattern and interpolate it against the object. (see `URLForObject:method:`)
 3. **By object relationship**. Routes can be defined for relationships to other objects. When a URL is requested from the router for a relationship, the router will retrieve the appropriate route for the relationship from the route set and interpolate the route's path pattern against the source object. (see `URLForRelationship:ofObject:method:`)

 @see `RKRoute`
 @see `RKRouteSet`
 */
@interface RKRouter : NSObject

///----------------------------
/// @name Initializing a Router
///----------------------------

/**
 Initializes a router with a given base URL.

 @param baseURL The base URL with which to initialize the receiver.
 @return The receiver, initialized with the given base URL.
 */
- (id)initWithBaseURL:(NSURL *)baseURL;

///----------------------
/// @name Generating URLs
///----------------------

/**
 Generates a URL for the route with the given name.

 The route set is searched for a route with the given name and a new `NSURL` object is instantiated
 with the baseURL of the receiver and the path pattern of the route, optionally interpolated
 with a given object. If a pointer to an `RKRequestMethod` variable is provided, the HTTP method
 for the route will be assigned to the reference.

 @param routeName The name of the route for which a URL is to be generated.
 @param method A pointer to an `RKRequestMethod` variable in which to store the HTTP method associated
    with the named route. May be nil.
 @param object An optional object against which to interpolate the path pattern.
 @return A new `NSURL` object constructed by appending the path pattern to the baseURL of the
    receiver and interpolating against a given object; or nil if no route was found with the given
    name.
 */
- (NSURL *)URLForRouteNamed:(NSString *)routeName method:(out RKRequestMethod *)method object:(id)object;

/**
 Generates a URL for a given object and HTTP method.

 The route set is searched for a route that matches the HTTP method and class of
 the object being routed. If there is not an exact match for the object's class, the inheritance
 hierarchy is searched until a match is found or all possible routes are exhausted. Exact HTTP request
 matches are favored over the wildcard method (`RKRequestMethodAny`). Once the appropriate route is identified,
 a new `NSURL` object is instantiated with the baseURL of the receiver and the path pattern of the route,
 interpolated against the object being routed.

 @param object The object for which a URL is to be generated.
 @param method The HTTP method for which the URL is to be generated.
 @return A new URL object constructed by appending the path pattern of the route for the object and
 HTTP method to the baseURL of the receiver, interpolated against the routed object; or nil if no route was found
 for the given object and HTTP method.
 */
- (NSURL *)URLForObject:(id)object method:(RKRequestMethod)method;

/**
 Generates a URL for a relationship of a given object with a given HTTP method.

 The route set is searched for a route that matches the relationship of the given object's class and the given
 HTTP method. If a matching route is found, a new `NSURL` object is instantiated with the baseURL of the receiver
 and the path pattern of the route, interpolated against the object being routed.

 @param relationshipName The name of the relationship for which a URL is to be generated.
 @param object The object for which the URL is to be generated.
 @param method The HTTP method for which the URL is to be generated.
 @return A new URL object constructed by appending the path pattern of the route for the given object's
 relationship and HTTP method to the baseURL of the receiver, interpolated against the routed object; or nil if no
 route was found for the given relationship, object and HTTP method.
 */
- (NSURL *)URLForRelationship:(NSString *)relationshipName ofObject:(id)object method:(RKRequestMethod)method;

///---------------------------------------------
/// @name Configuring the Base URL and Route Set
///---------------------------------------------

/**
 The base URL that all URLs constructed by the receiver are relative to.
 */
@property (nonatomic, strong, readonly) NSURL *baseURL;

/**
 A route set defining all the routes addressable through the receiver.
 */
@property (nonatomic, strong, readonly) RKRouteSet *routeSet;

@end
