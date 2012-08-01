//
//  CCViewController.m
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 2/3/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CCMainViewController.h"
#import "CalorieDetailViewCell.h"
#import "BorderedSpinnerView.h"
#import "CCDataManager.h"


@implementation CCMainViewController
@synthesize navBar;
@synthesize navItem;
@synthesize dateLabel;

@synthesize table, calorieTotal, totalCals, numRows, rowNumberCount, movedPosition, borderedSpinnerView, currentDay;

static CCMainViewController * CCViewControllerInstance;


/*
-(id) init
{
    if ((self = [super init]))
    {
        NSAssert(CCViewControllerInstance == nil, @"another CCViewController is in use!");
        CCViewControllerInstance = self;
    }

    return self;

}
 */

+(CCMainViewController *) sharedCCViewController
{
    NSAssert(CCViewControllerInstance != nil, @"CCViewController not available!");
    return CCViewControllerInstance;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CCViewControllerInstance = self;
    borderedSpinnerView = [[BorderedSpinnerView alloc] init];


    //set up days and core data
    CCDataManager *ccDataManager = [[CCDataManager alloc] init];
    currentDay = [ccDataManager getDayWithDate:[NSDate date]];
    if (currentDay == nil)
    {
        currentDay = [ccDataManager createNewDayWithDate:[NSDate date]];
    }

    [ccDataManager displayAllDays];

    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@/%@", currentDay.month, currentDay.day, currentDay.year];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addRow)];

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"83-calendar.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(presentCalendarView)];
    self.navItem.rightBarButtonItem = rightButton;
    self.navItem.leftBarButtonItem = leftButton;


    totalCals = 0;
    numRows = currentDay.foodEntries.count;
    rowNumberCount = 0;
}

-(void) addRow
{
    numRows++;
    [[CCDataManager sharedInstance] createNewFoodEntryWithDay:currentDay];
    [self.table reloadData];
    [[CCDataManager sharedInstance] displayEntriesForDay:currentDay];
}

-(void) presentCalendarView
{
    NSLog(@"presentCalendar");
}

-(void) displayLoadingScreen
{
    [self.view.superview insertSubview:borderedSpinnerView.view aboveSubview:self.view];

    //[self.superview.superview insertSubview:borderedSpinnerView.view aboveSubview:self];
}

-(void) stopLoadingScreen
{
    [borderedSpinnerView.view removeFromSuperview];
}

- (void)viewDidUnload
{
    [self setCalorieTotal:nil];
    [self setTable:nil];
    [self setNavBar:nil];
    [self setNavItem:nil];
    [self setDateLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)backgroundTap:(id)sender
{
    [self removeKeyboard];
    [self resetView];
}

-(void) removeKeyboard
{
    for (int i = 0; i <numRows; i++)
    {
        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        CalorieDetailViewCell* cell1 = (CalorieDetailViewCell*) [table cellForRowAtIndexPath:a];
        [cell1.foodNameLabel resignFirstResponder];
        [cell1.consumedCalories resignFirstResponder];

    }
}

-(void)updateTotalCals
{
    int total = 0;

    for (int i = 0; i < numRows; i++)
    {

        NSIndexPath *a = [NSIndexPath indexPathForRow:i inSection:0];
        CalorieDetailViewCell* cell1 = (CalorieDetailViewCell*) [table cellForRowAtIndexPath:a];
        total+= [cell1.consumedCalories.text intValue];
    }

    totalCals = total;
    calorieTotal.text = [NSString stringWithFormat:@"\@%i",totalCals];
}


-(void) animateView: (int)distance
{
    movedPosition = distance;

    const float movementduration = 0.3f;

    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementduration];
    self.view.frame = CGRectOffset(self.view.frame, 0, distance);
    [UIView commitAnimations];
}


-(void) resetView
{
    int distance = movedPosition*-1;
    movedPosition = 0;

    const float movementduration = 0.3f;
    //int temp = self.view.frame.;

//    NSLog(@"distance %i",distance);

    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementduration];
    self.view.frame = CGRectOffset(self.view.frame, 0, distance);
    [UIView commitAnimations];

}

#pragma mark -
#pragma mark Table Data Source Method
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return numRows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellTableIdentifier = @"CalorieDetailViewCell";

    static BOOL nibsRegistered = NO;

    UITableViewCell* cell;

    if (!nibsRegistered)
    {
        UINib* nib1 = [UINib nibWithNibName:@"CalorieDetailViewCell" bundle:nil];
        [tableView registerNib:nib1 forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }

    CalorieDetailViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];

    if (!cell1.rowNumber)
    {
//        NSLog(@"rownumbercount %i", rowNumberCount);
        FoodEntry *foodEntry = [currentDay.foodEntries objectAtIndex:indexPath.row];
        cell1.foodEntry = foodEntry;
        cell1.foodNameLabel.text = foodEntry.food.foodName;
        cell1.consumedCalories.text = [NSString stringWithFormat:@"%i", [foodEntry.food.foodCalories intValue]];
        cell1.rowNumber = rowNumberCount;
        cell1.currentDay = currentDay;
        rowNumberCount++;
    }

    cell = cell1;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

@end
