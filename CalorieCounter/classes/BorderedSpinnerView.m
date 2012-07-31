//
//  BorderedSpinnerView.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 2/15/12.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "BorderedSpinnerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BorderedSpinnerView
@synthesize spinnerImageView;
@synthesize button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createAndDisplaySpinner];
    [[button layer] setCornerRadius:80.0f];
    [[button layer] setBorderWidth:1.0f];

}

- (void)viewDidUnload
{
    [self stopSpinner];
    [self setSpinnerImageView:nil];
    [self setButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




-(void) createAndDisplaySpinner {
    
   
    
    // NSLog(@"spiner displayed");
    CGFloat width = spinnerImageView.bounds.size.width;
    CGFloat height = spinnerImageView.bounds.size.height;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner setCenter:CGPointMake(width/2.0,height/2.0)];
    [self.spinnerImageView addSubview:spinner];
    [spinner startAnimating];
    //[self.view setNeedsDisplay];
    
}

-(void) stopSpinner {
    
    //NSLog(@"spinner hidden");
    
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    
}

@end
