//
//  NSString+NSString_URLEncoding.m
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 3/5/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "NSString+NSString_URLEncoding.h"

@implementation NSString (NSString_URLEncoding)


-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
	return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
