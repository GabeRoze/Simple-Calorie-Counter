//
//  FoodEntry.h
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Food;

@interface FoodEntry : NSManagedObject

@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) Day *date;
@property (nonatomic, retain) Food *food;

@end
