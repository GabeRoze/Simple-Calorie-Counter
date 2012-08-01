//
//  Day.h
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Food;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSNumber * dayGoal;
@property (nonatomic, retain) NSNumber * netGoal;
@property (nonatomic, retain) NSNumber * totalCalories;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSOrderedSet *foodEntries;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)insertObject:(Food *)value inFoodEntriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFoodEntriesAtIndex:(NSUInteger)idx;
- (void)insertFoodEntries:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFoodEntriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFoodEntriesAtIndex:(NSUInteger)idx withObject:(Food *)value;
- (void)replaceFoodEntriesAtIndexes:(NSIndexSet *)indexes withFoodEntries:(NSArray *)values;
- (void)addFoodEntriesObject:(Food *)value;
- (void)removeFoodEntriesObject:(Food *)value;
- (void)addFoodEntries:(NSOrderedSet *)values;
- (void)removeFoodEntries:(NSOrderedSet *)values;
@end
