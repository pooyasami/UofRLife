//
//  TouchLocator.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-05.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "TouchLocator.h"


@implementation TouchLocator

@synthesize name, area;



-(id) initWithName:(NSMutableString*)name1 andRectangle:(CGRect)area1 {
	[super init];
	name = name1;
	area = area1;
	return self;
}

-(BOOL) findIfThePointIsInsideTheRectangle: (CGPoint)point {
	return CGRectContainsPoint(area, point);
}

@end
