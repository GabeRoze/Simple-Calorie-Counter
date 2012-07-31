//
//  XMLParser.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 12/30/11.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XMLElement;

@interface XMLParser : UIResponder <UIApplicationDelegate, NSXMLParserDelegate> {
    
    int commentCount;
    NSString* flag;
}


@property (strong, nonatomic) NSString* calResult;

@property (strong, nonatomic) NSXMLParser* xmlParser;

@property (strong, nonatomic) XMLElement* rootElement;
@property (strong, nonatomic) XMLElement* currentElementPointer;

@property (strong, nonatomic) NSMutableDictionary* favoriteResult;
@property (strong, nonatomic) NSMutableDictionary* loginResult;
@property (strong, nonatomic) NSMutableDictionary* registerResult;
@property (strong, nonatomic) NSMutableDictionary* dealItem;
@property (strong, nonatomic) NSMutableArray* dealListArray;
@property (strong, nonatomic) NSMutableArray* dealComments;
@property (strong, nonatomic) NSString* dealTagStatus;
@property (strong, nonatomic) NSString* currentTag;

- (XMLParser *) initXMLParser:(NSData*)data;



@end
