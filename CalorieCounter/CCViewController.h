//
//  CCViewController.h
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 2/3/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderedSpinnerView;

@interface CCViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) int totalCals;
@property (weak, nonatomic) IBOutlet UITextField *calorieTotal;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (assign, nonatomic) int numRows;
@property (assign, nonatomic) int rowNumberCount;
@property (assign, nonatomic) int movedPosition;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;

+(CCViewController*)sharedCCViewController;

-(void)updateTotalCals;
-(void) removeKeyboard;
-(void) animateView: (int)distance;
-(void) resetView;
-(void) displayLoadingScreen;
-(void) stopLoadingScreen;

- (IBAction)backgroundTap:(id)sender;

@end
