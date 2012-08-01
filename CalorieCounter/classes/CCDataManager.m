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

-(Day *)getDayWithDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
//    NSInteger day = [components day];
//    NSInteger month = [components month];
//    NSInteger year = [components year];

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
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
//    NSInteger day = [components day];
//    NSInteger month = [components month];
//    NSInteger year = [components year];

    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"day == %@ AND month == %@ AND year == %@",day.day, day.month, day.year];

//    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date ==%@", day.date];
    NSArray *days = [self fetchEntityForEntityName:@"Day" withPredicate:predicate];

    if ([days count] > 0)
    {
        Day *dayFromMemory = [days objectAtIndex:0];
        dayFromMemory = day;

        NSError *savingError = nil;

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

@end
