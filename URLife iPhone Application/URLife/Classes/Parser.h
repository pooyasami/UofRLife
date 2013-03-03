//
//  Parser.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-04.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This is the parser class that parses through all the data that is coming from
 the PHP service
 */
@interface Parser : NSObject <NSXMLParserDelegate> {
	/**
	 Data coming from the request
	 */
	NSData *data;
	/**
	 Current element that is being processsed
	 */
	NSMutableDictionary *currentElement;
	/**
	 The result array which holds all the data that has been parsed
	 */
	NSMutableArray *result;
	/**
	 The XML key that is being processed
	 */
	NSString *keyInProgress;
	/**
	 The string that holds the information under process
	 */
	NSMutableString *textInProgress;
	
	/**
	 The accepted keys that need to be parsed
	 */
	NSArray *acceptedKeys;
	/**
	 The delimiter
	 */
	NSString *delimeter;
}

@property (nonatomic, retain) NSMutableArray *result;

/**
 After proper initialization, this function starts the parsing method.
 @return returns an array of the data that has been parsed.
 */
-(NSMutableArray*) parseXML;
/**
 Is the initializing method for this class, it gets the accepted keys and the delimiter
 @param dataFromRequest the data
 @param acceptedKeys1 it is the array of the keys that need to be stored in each object
 @param delimiter1 it holds the type of the data (event/establishemt/feedback...).
 */
-(id) initWithData:(NSData*)dataFromRequest withKeys:(NSArray*)acceptedKeys1 delimiter:(NSString*)delimiter1;
@end
