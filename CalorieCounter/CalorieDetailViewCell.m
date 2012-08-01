//
//  CalorieDetailViewCell.m
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 2/3/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CalorieDetailViewCell.h"
#import "CCMainViewController.h"
#import "BorderedSpinnerView.h"
#import "XMLParser.h"
#import "CCDataManager.h"

@implementation CalorieDetailViewCell

@synthesize foodNameLabel, foodEntry, consumedCalories, rowNumber, borderedSpinnerView, messageText, parser, currentDay;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        borderedSpinnerView = [[BorderedSpinnerView alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)foodLabelDonePressed:(id)sender
{

    CCDataManager *dataManager = [CCDataManager sharedInstance];
    //check if food name exists
    //if no food exists, add it
    if (![dataManager getFoodWithString:foodNameLabel.text])
    {
        self.foodEntry.food = [dataManager createNewFoodWithString:foodNameLabel.text];
    }
    else if ([dataManager getFoodWithString:foodNameLabel.text])
    {
        //food exists - set cals
        self.foodEntry.food = [dataManager getFoodWithString:foodNameLabel.text];
        self.consumedCalories.text = [NSString stringWithFormat:@"%i",[self.foodEntry.food.foodCalories intValue]];
    }


    [self.consumedCalories becomeFirstResponder];
    [dataManager displayAllFoods];
}

- (IBAction)editingDidBegin:(id)sender
{
    [[CCMainViewController sharedCCViewController] resetView];
    [[CCMainViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
}

- (IBAction)calorieEditingDidBegin:(id)sender
{
    [[CCMainViewController sharedCCViewController] resetView];
    [[CCMainViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
//    [[CCViewController sharedCCViewController] displayLoadingScreen];
//    [self connectToServer:foodNameLabel.text];
}

- (IBAction)calorieDoneButtonPressed:(id)sender
{
    [self valueChanged];
}

-(void) valueChanged
{
    //NSLog(@"animateview done %f", (self.frame.size.height*rowNumber));
    foodEntry.food.foodCalories = [NSNumber numberWithInt:[self.consumedCalories.text intValue]];
    [[CCDataManager sharedInstance] updateFoodEntryWithFoodEntry:foodEntry];

    [[CCMainViewController sharedCCViewController] updateTotalCals];
    [[CCMainViewController sharedCCViewController] removeKeyboard];
    [[CCMainViewController sharedCCViewController] resetView];//animateView: self.frame.size.height * (rowNumber+1)];


    [[CCDataManager sharedInstance] displayAllFoods];
}

@end
