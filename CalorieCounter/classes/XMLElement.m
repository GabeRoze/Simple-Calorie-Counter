//
//  XMLElement.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-30.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "XMLElement.h"

@implementation XMLElement

@synthesize name;
@synthesize text;
@synthesize attributes;
@synthesize subElements;
@synthesize parent;


-(NSMutableArray*) subElements{
    if (subElements == nil) {
        subElements = [[NSMutableArray alloc] init];
    }
    
    //NSLog(@"subElements: %@",subElements);
    return subElements;
}


@end
