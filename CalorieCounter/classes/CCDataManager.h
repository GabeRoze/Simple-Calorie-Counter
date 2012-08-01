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
#import "CCAppDelegate.h"

@interface CCDataManager : NSObject

+(CCDataManager*)sharedInstance;

-(Day *)getDayWithDate:(NSDate *)date;
-(Day *)createNewDayWithDate:(NSDate *)date;
-(void)updateDayWithDay:(Day *)day;

//todo delete
-(void)displayAllDays;

@property (nonatomic, strong) CCAppDelegate *appDelegate;

@end
