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

    // Configure the view for the selected state
}


- (IBAction)foodLabelDonePressed:(id)sender {
    
    [self.consumedCalories becomeFirstResponder];
    //NSLog(@"food entered!");
}

- (IBAction)editingDidBegin:(id)sender {
    
//    NSLog(@"animateview begin %f", (self.frame.size.height*rowNumber*-1));

    [[CCViewController sharedCCViewController] resetView];
    [[CCViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
    
}

- (IBAction)calorieEditingDidBegin:(id)sender {
    
    
    [[CCViewController sharedCCViewController] resetView];
    [[CCViewController sharedCCViewController] animateView: 32 * (rowNumber*-1)];
    
    //NSLog(@"cal thing editing start woo");
    
    //Call loading screen
    //call connect to server
    [[CCViewController sharedCCViewController] displayLoadingScreen];
    //[self.superview.superview insertSubview:borderedSpinnerView.view aboveSubview:self];
    
    [self connectToServer:foodNameLabel.text];

}

- (IBAction)calorieDoneButtonPressed:(id)sender {

    [self valueChanged];
}


-(void) valueChanged {

    //NSLog(@"animateview done %f", (self.frame.size.height*rowNumber));

    [[CCViewController sharedCCViewController] updateTotalCals];
    [[CCViewController sharedCCViewController] removeKeyboard];
    [[CCViewController sharedCCViewController] resetView];//animateView: self.frame.size.height * (rowNumber+1)];

}

#pragma mark - 
#pragma mark Server Connectivity and XML

-(void) connectToServer:(NSString*)data {
    
//    http://api.wolframalpha.com/v2/query?input=banana+calories&format=plaintext&appid=GRUUG4-HPLH3JL4P8
    
    
    
    
    // Setup URLRequest data
    
    NSString* urlAsString = [NSString stringWithFormat:@"http://api.wolframalpha.com/v2/query?input=%@+calories&format=plaintext&appid=GRUUG4-HPLH3JL4P8", data];//[self urlEncodeUsingEncoding:NSUTF8StringEncoding str:data]]; //NSUTF8Encoding]];
    
    /*
    
    NSString* emailString = [NSString stringWithFormat:@"useremail=%@",(NSString*)[userData objectAtIndex:0] ];
    NSString* encryptedPassword = (NSString*)[userData objectAtIndex:1];
    NSString* passwordString = [NSString stringWithFormat:@"&userpw=%@",encryptedPassword ];
    urlAsString = [urlAsString stringByAppendingString:emailString];
    urlAsString = [urlAsString stringByAppendingString:passwordString];    
    
    NSString* functionUrl = @"http://www.cinnux.com/userlogin-func.php/";
    */
    
    
    //NSMutableURLRequest *urlRequest = [CalculationHelper getURLRequest:functionUrl withData:urlAsString];
    
    //NSData *myRequestData = [NSData dataWithBytes: [urlAsString UTF8String] length: [urlAsString length]];
    
    

    NSLog(@"urlstr: %@", urlAsString);

    NSURL* url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    /*
    
     
    
     
    NSString* urlAsString = data;
    NSLog(@"urlstr: %@", urlAsString);
    NSData *myRequestData = [NSData dataWithBytes: [urlAsString UTF8String] length: [urlAsString length]];
    
    //    NSURL* url = [NSURL URLWithString:@"http://www.cinnux.com/userlogin-func.php/"];
    
    NSURL* url = [NSURL URLWithString:functionURL];
    
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:myRequestData];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    */
    
    
   // NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //NSError* error = [NSError alloc];   
   // NSDictionary* dict = [[NSDictionary alloc] init];
    NSError* error = nil;
   // [NSError errorWithDomain:NSOSStatusErrorDomain code:1 userInfo:dict];
   
    NSData *returnData = [NSURLConnection sendSynchronousRequest: urlRequest returningResponse: nil error: &error];
    
    
    //NSLog(@"error: %@", error);

    
//    [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];
    
    NSString* html = [[NSString alloc] 
                      initWithData:returnData
                      encoding:NSUTF8StringEncoding];
    //NSLog (@"HTML = %@", html);
    
    [self parseXMLFile:returnData];
    
    /*
    [NSURLConnection 
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response, NSData* data, NSError* error) {
         
         if ([data length] > 0 && error == nil) {
             NSString* html = [[NSString alloc] 
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
             NSLog (@"HTML = %@", html);
             
             
             //parse file
             [self performSelectorInBackground:@selector(parseXMLFile:) withObject:data];
             
             
             
         }
         else if ([data length] == 0 && error == nil) {
             //NSLog(@"Nothing was downloaded.");
             messageText = @"Server not responding";
         }
         else if (error != nil) {
             //NSLog(@"Error happened = %@", error);
             messageText = @"Error occured during login";
             
             
         }
     }];
     */
    
}


-(void) serverResponseAcquired {
    
    
    NSRange startRange = [parser.calResult rangeOfString:@" "];
    NSString *noBrackets = [parser.calResult substringToIndex:startRange.location];
    
    NSLog(@"THE RESULTWILL BE: %@", noBrackets);
    //[original stringByReplacingOccurrencesOfString:@"\[" withString:@"" options:0 range:searchRange];

    consumedCalories.text = noBrackets;
    
    //[self stopSpinner];
    //[self dismissModalViewControllerAnimated:NO];   
    //[borderedSpinnerView.view removeFromSuperview];
    
    [[CCViewController sharedCCViewController] stopLoadingScreen];
    
    
    NSLog(@"done!");
    /*
    if ([messageText isEqualToString:@"success"]) {
        
        [self loginSuccess];
    }
    else if ([messageText isEqualToString:@"fail"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid username and password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];  
        [self stopSpinner];
    }
    else if ([messageText isEqualToString:@"Server not responding"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self stopSpinner];
    }
    else if ([messageText isEqualToString:@"Error occured during login"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageText message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self stopSpinner];
    }
    */
    //NSLog(@"message text: %@", messageText);
    messageText = @"Server response acquired";
    
}


-(void) parseXMLFile:(NSData*)data {
    parser = [[XMLParser alloc] initXMLParser:data];
    //[self performSelectorOnMainThread:@selector(stopSpinner) withObject:nil waitUntilDone:YES];
    
    //NSLog(@"firstname %@",[parser.loginResult objectForKey:@"userfirstname"]);
    //NSLog(@"lastname %@",[parser.loginResult objectForKey:@"userlastname"]);
    //messageText = [parser.loginResult objectForKey:@"message"];
    //[self performSelectorOnMainThread:@selector(serverResponseAcquired) withObject:nil waitUntilDone:YES];
    [self serverResponseAcquired]; 
    
}


-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding str:(NSString*)str {
	return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(encoding));
}


@end
