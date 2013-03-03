//
//  EventIcons.m
//  TabBar1
//
//  Created by Developer on 11-03-21.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "EventIcons.h"


@implementation EventIcons

-(id)init {
	
	[super init];
	icons = [[NSMutableArray alloc] init];
	[icons addObject:[UIImage imageNamed:@"48-fork-and-knife.png"]];
	[icons addObject:[UIImage imageNamed:@"88-beer-mug.png"]];
	[icons addObject:[UIImage imageNamed:@"96-book.png"]];
	[icons addObject:[UIImage imageNamed:@"104-index-cards.png"]];
	[icons addObject:[UIImage imageNamed:@"63-runner.png"]];
	return self;
	
}

-(UIImage*) imageAccordingToEventType:(NSString*)type{
	if ([type isEqual:@"food"]) {
		return [icons objectAtIndex:0];
	}
	
	if ([type  isEqual:@"party"]) {
		return [icons objectAtIndex:1];
	}
	
	if ([type  isEqual:@"presentation"]) {
		return [icons objectAtIndex:2];
	}
	
	if ([type isEqual:@"fair"]) {
		return [icons objectAtIndex:3];
	}
	if ([type isEqual:@"sport"]) {
		return [icons objectAtIndex:4];
	}
	return nil;
}

@end
