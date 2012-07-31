//
//  CalorieDetailViewCell.h
//  CalorieCounter
//
//  Created by Gabe Rozenberg on 2/3/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BorderedSpinnerView;
@class XMLParser;


@interface CalorieDetailViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *consumedCalories;
@property (weak, nonatomic) IBOutlet UITextField *foodNameLabel;
@property (assign, nonatomic) int rowNumber;
@property (strong, nonatomic) BorderedSpinnerView* borderedSpinnerView;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) XMLParser* parser;


- (IBAction)calorieDoneButtonPressed:(id)sender;
- (IBAction)foodLabelDonePressed:(id)sender;


- (IBAction)editingDidBegin:(id)sender;
- (IBAction)calorieEditingDidBegin:(id)sender;

-(void) valueChanged;
-(void) connectToServer:(NSString*)data;
-(void) parseXMLFile:(NSData*)data;
-(void) serverResponseAcquired;
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding str:(NSString*)str;

@end
