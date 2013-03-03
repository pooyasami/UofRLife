//
//  PostMethod.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-04.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "PostMethod.h"


@implementation PostMethod

-(NSData*) postThisString:(NSString*) post{
	
	NSMutableData *postData = [NSMutableData data];
	[postData appendData:[post dataUsingEncoding:NSUTF8StringEncoding]];
	NSString *postLength = [NSString stringWithFormat:@"@d", [postData length]];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://mobile.myurlife.ca/urlifemobile.php"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"MyApp=V1.0" forHTTPHeaderField:@"User-Agent"];
	[request setHTTPBody:postData];
	
	NSData *data1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	return data1;
}


@end
