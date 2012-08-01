//
//  CCDataManager.m
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CCDataManager.h"

@implementation CCDataManager

static CCDataManager *sharedInstance = nil;

@synthesize appDelegate;

- (id)init {
    if ((self = [super init]))
    {
        appDelegate = (CCAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(FoodEntry *)createNewFoodEntryWithDay:(Day *)day
{
    FoodEntry *newFoodEntry = [NSEntityDescription insertNewObjectForEntityForName:@"FoodEntry" inManagedObjectContext:appDelegate.managedObjectContext];
    newFoodEntry.date = day;
    newFoodEntry.count = [NSNumber numberWithInteger:day.foodEntries.count];
    [self saveContext];

    return newFoodEntry;
}

-(void)updateFoodEntryWithFoodEntry:(FoodEntry *)foodEntry
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date ==  %@ AND count == %@", foodEntry.date, foodEntry.count];
    NSArray *foodEntries = [self fetchEntityForEntityName:@"FoodEntry" withPredicate:predicate];

    if ([foodEntries count] > 0)
    {
        FoodEntry *foodEntryFromMemory = [foodEntries objectAtIndex:0];
        foodEntryFromMemory = foodEntry;
        [self saveContext];
    }
}

-(Food *)createNewFoodWithString:(NSString *)foodName
{
    Food *newFood =  [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:appDelegate.managedObjectContext];
    newFood.foodName = foodName;
    [self saveContext];

    return newFood;
}

-(Food *)getFoodWithString:(NSString *)foodName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodName ==  %@", foodName];
    NSArray *foods = [self fetchEntityForEntityName:@"Food" withPredicate:predicate];

    if ([foods count] > 0)
    {
        return  (Food *)[foods objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

-(void)updateFoodWithFood:(Food *)food
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodName ==  %@", food.foodName];
    NSArray *foods = [self fetchEntityForEntityName:@"Food" withPredicate:predicate];

    if ([foods count] > 0)
    {
        Food *foodFromMemory = [foods objectAtIndex:0];
        foodFromMemory = food;
        [self saveContext];
    }
}

-(Day *)getDayWithDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];

    NSNumber *getDay = [NSNumber numberWithInteger:[components day]];
    NSNumber *getMonth = [NSNumber numberWithInteger:[components month]];
    NSNumber *getYear = [NSNumber numberWithInteger:[components year]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"day == %@ AND month == %@ AND year == %@", getDay, getMonth, getYear];
    NSArray *days = [self fetchEntityForEntityName:@"Day" withPredicate:predicate];

    if ([days count] > 0)
    {
        return (Day *)[days objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

-(Day *)createNewDayWithDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSNumber *getDay = [NSNumber numberWithInteger:[components day]];
    NSNumber *getMonth = [NSNumber numberWithInteger:[components month]];
    NSNumber *getYear = [NSNumber numberWithInteger:[components year]];

    Day *newDay = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:appDelegate.managedObjectContext];
    newDay.day = getDay;
    newDay.month = getMonth;
    newDay.year = getYear;

    [self saveContext];

    return newDay;
}

-(void)updateDayWithDay:(Day *)day
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"day == %@ AND month == %@ AND year == %@",day.day, day.month, day.year];
    NSArray *days = [self fetchEntityForEntityName:@"Day" withPredicate:predicate];

    if ([days count] > 0)
    {
        Day *dayFromMemory = [days objectAtIndex:0];
        dayFromMemory = day;
        [self saveContext];
    }
}

-(NSArray *)fetchEntityForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];

    if (predicate) [fetchRequest setPredicate:predicate];

    NSError *requestError = nil;
    NSArray *entityArray = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];

    if ([entityArray count] > 0)
    {
        return entityArray;
    }
    else
    {
        return [[NSArray alloc] init];
    }
}

-(void)saveContext
{
    NSError *savingError = nil;
    if ([appDelegate.managedObjectContext save:&savingError])
    {
        NSLog(@"succesfully saved context");
    }
    else
    {
        NSLog(@"Failed to save to data store: %@", [savingError localizedDescription]);
        NSArray* detailedErrors = [[savingError userInfo] objectForKey:NSDetailedErrorsKey];
        if(detailedErrors != nil && [detailedErrors count] > 0) {
            for(NSError* detailedError in detailedErrors) {
                NSLog(@"  DetailedError: %@", [detailedError userInfo]);
            }
        }
        else {
            NSLog(@"  %@", [savingError userInfo]);
        }
    }
}

#pragma mark Singleton
+ (CCDataManager *)sharedInstance
{
    static CCDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark Test Methods
-(void)displayAllDays
{
    NSArray *days = [self fetchEntityForEntityName:@"Day" withPredicate:nil];

    for (int i = 0; i < [days count]; i++)
    {
        Day *day = [days objectAtIndex:i];
        NSLog(@"DAY: %@", day.day);
        NSLog(@"MONTH: %@", day.month);
        NSLog(@"YEAR: %@\n", day.year);
    }
}

-(void)displayEntriesForDay:(Day *)day
{
    for (int i = 0; i < [day.foodEntries count]; i++)
    {
        FoodEntry *foodEntry = [day.foodEntries objectAtIndex:i];
        NSLog(@"FOOD NAME: %@", foodEntry.food.foodName);
        NSLog(@"FOOD CALS: %@", foodEntry.food.foodCalories);
        NSLog(@"DATE DAY: %@", foodEntry.date.day);
        NSLog(@"COUNT: %@", foodEntry.count);
    }
}

-(void)displayAllFoods
{
    NSArray *foods = [self fetchEntityForEntityName:@"Food" withPredicate:nil];
    for (int i = 0; i < [foods count]; i++)
    {
        Food *food = [foods objectAtIndex:i];
        NSLog(@"FOODNAME: %@", food.foodName);
        NSLog(@"FOODCALS: %@", food.foodCalories);
    }
}
@end
