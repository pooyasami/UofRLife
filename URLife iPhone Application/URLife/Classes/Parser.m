//
//  Parser.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-04.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "Parser.h"


@implementation Parser

@synthesize result;


-(id) initWithData:(NSData*)dataFromRequest withKeys:(NSArray*)acceptedKeys1 delimiter:(NSString*)delimiter1{
	self = [super init];
    if (self) {
        /* class-specific initialization goes here */
		data = dataFromRequest;
		acceptedKeys = acceptedKeys1;
		delimeter = delimiter1;
	}
    return self;
}


-(NSMutableArray*) parseXML {
	//NSData *data = [xmlContent dataUsingEncoding:NSASCIIStringEncoding];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	result = [[NSMutableArray alloc] init];
	
	[parser setDelegate:self];
	NSLog(@"Parsing Started");
	[parser parse];
	[parser release];
	return result;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	if ([elementName isEqual:delimeter]) {
		currentElement = [[NSMutableDictionary alloc] init];
		return;
	} else if ([elementName isEqual:@"root"]){
		return;
	} else {
		keyInProgress = [elementName copy];
		textInProgress = [[NSMutableString alloc] init];
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[textInProgress appendString:string];
	[pool drain];
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([acceptedKeys containsObject:elementName]) {
		[currentElement setObject:textInProgress forKey:elementName];
		[textInProgress release];
		//NSLog(@"text in progress %@ = %@", elementName,textInProgress);
		
	} else if ([elementName isEqual:@"root"]){
		return;
	} else if ([elementName isEqual:delimeter]){
		[result addObject:currentElement];
	}
	
}

-(void)dealloc {
	[super dealloc];
	[currentElement release];
	[keyInProgress release];
	//[textInProgress release];
	[acceptedKeys release];
	
}
@end
