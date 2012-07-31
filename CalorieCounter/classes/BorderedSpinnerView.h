//
//  BorderedSpinnerView.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 2/15/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorderedSpinnerView : UIViewController {

    UIActivityIndicatorView* spinner;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *spinnerImageView;
@property (weak, nonatomic) IBOutlet UILabel *button;

-(void) createAndDisplaySpinner; 
-(void) stopSpinner;


@end
