//
//  CCDataManager.h
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
#import "Food.h"
#import "FoodEntry.h"
#import "CCAppDelegate.h"

@interface CCDataManager : NSObject

+(CCDataManager*)sharedInstance;

-(FoodEntry *)createNewFoodEntryWithDay:(Day *)day;
-(void)updateFoodEntryWithFoodEntry:(FoodEntry *)foodEntry;

-(Day *)getDayWithDate:(NSDate *)date;
-(Day *)createNewDayWithDate:(NSDate *)date;
-(void)updateDayWithDay:(Day *)day;

-(Food *)createNewFoodWithString:(NSString *)foodName;
-(Food *)getFoodWithString:(NSString *)foodName;
-(void)updateFoodWithFood:(Food *)food;


//todo delete
-(void)displayAllDays;
-(void)displayEntriesForDay:(Day *)day;
-(void)displayAllFoods;

@property (nonatomic, strong) CCAppDelegate *appDelegate;

@end
