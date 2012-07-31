//
//  Food.h
//  CalorieCounter
//
//  Created by Gabriel Rozenberg on 7/31/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food : NSManagedObject

@property (nonatomic, retain) NSString * foodName;
@property (nonatomic, retain) NSNumber * foodCalories;
@property (nonatomic, retain) NSNumber * timesEaten;

@end
