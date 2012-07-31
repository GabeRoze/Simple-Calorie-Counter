//
//  Day.h
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Day : NSManagedObject

@property (nonatomic, retain) NSNumber * dayGoal;
@property (nonatomic, retain) NSNumber * netGoal;
@property (nonatomic, retain) NSNumber * totalCalories;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSOrderedSet *foodEntries;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inFoodEntriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFoodEntriesAtIndex:(NSUInteger)idx;
- (void)insertFoodEntries:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFoodEntriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFoodEntriesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceFoodEntriesAtIndexes:(NSIndexSet *)indexes withFoodEntries:(NSArray *)values;
- (void)addFoodEntriesObject:(NSManagedObject *)value;
- (void)removeFoodEntriesObject:(NSManagedObject *)value;
- (void)addFoodEntries:(NSOrderedSet *)values;
- (void)removeFoodEntries:(NSOrderedSet *)values;
@end
