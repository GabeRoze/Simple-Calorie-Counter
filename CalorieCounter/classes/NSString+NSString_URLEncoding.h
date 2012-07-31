//
//  NSString+NSString_URLEncoding.h
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 3/5/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_URLEncoding)


-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
