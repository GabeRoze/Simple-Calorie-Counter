//
//  CalorieDetailViewCell.m
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 2/3/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CalorieDetailViewCell.h"
#import "CCViewController.h"
#import "BorderedSpinnerView.h"
#import "XMLParser.h"

@implementation CalorieDetailViewCell
@synthesize foodNameLabel;
@synthesize consumedCalories;
@synthesize rowNumber;
@synthesize borderedSpinnerView;
@synthesize messageText;
@synthesize parser;

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
    [self.consumedCalories becomeFirstResponder];
}

- (IBAction)editingDidBegin:(id)sender
{
    [[CCViewController sharedCCViewController] resetView];
    [[CCViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
}

- (IBAction)calorieEditingDidBegin:(id)sender
{
    [[CCViewController sharedCCViewController] resetView];
    [[CCViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
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

    [[CCViewController sharedCCViewController] updateTotalCals];
    [[CCViewController sharedCCViewController] removeKeyboard];
    [[CCViewController sharedCCViewController] resetView];//animateView: self.frame.size.height * (rowNumber+1)];
}

@end
