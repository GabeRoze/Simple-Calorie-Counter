//
//  XMLElement.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-30.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLElement : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDictionary* attributes;
@property (nonatomic, strong) NSMutableArray* subElements;
@property (nonatomic, weak) XMLElement *parent;

@end
