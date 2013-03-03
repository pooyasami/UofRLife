//
//  MapViewController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-17.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "TouchLocator.h"
#import "MapViewController.h"
#import "ShowInformationAccordingToLocation.h"
#import "PostMethod.h"
#import "Parser.h"
#import "Reachability.h"
#import "LegendViewController.h"
#import "TabBar1AppDelegate.h"

@implementation MapViewController

@synthesize imageV, scrollV;

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageV;
}

-(void)viewWillAppear:(BOOL)animated {
	self.navigationController.navigationBarHidden = YES;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationController.navigationBarHidden = YES;
	//self.view.backgroundColor = [UIColor blackColor];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Campus Map";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
	
}

-(void) loadLocationsInfo {
	if ([self checkConnection]) {
		NSString *post = @"action=getStats";
		PostMethod *pm = [[PostMethod alloc] init];
		NSData *data1 = [pm postThisString:post];
	
		Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"name",@"event",@"establishment",@"vmachine",nil] delimiter:@"building"];
		locationsInfo = [parser parseXML];
		[parser release];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"There is no internet connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}

- (void) loadView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	legendButtonLocation = CGRectMake(540.0, 25.0, 60.0, 60);
	
	locationsArray = [[NSMutableArray alloc] init];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Day Care" ] andRectangle:CGRectMake(237.0, 13.0, 53.0, 45.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"First Nation University of Canada" ] andRectangle:CGRectMake(396.0, 669.0, 55.0, 100.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Centre of Kinesiology" ] andRectangle:CGRectMake(157.0, 260.0, 60.0, 170.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Education Building" ] andRectangle:CGRectMake(115.0, 191.0, 90.0, 60.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Luther College" ] andRectangle:CGRectMake(281.0, 466.0, 60.0, 100.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Campion College" ] andRectangle:CGRectMake(279.0, 360.0, 60.0, 80.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Language Institute" ] andRectangle:CGRectMake(351.0, 277.0, 100.0, 50.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Administration-Humanities" ] andRectangle:CGRectMake(378.0, 219.0, 81.0, 41.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Dr. John Archer Library" ] andRectangle:CGRectMake(359.0, 130.0, 52.0, 82.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Classroom Building" ] andRectangle:CGRectMake(404.0, 32.0, 57.0, 90.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Laboratory Building" ] andRectangle:CGRectMake(334.0, 18.0, 67.0, 67.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Research and Innovation Centre" ] andRectangle:CGRectMake(289.0, 9.0, 44.0, 85.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"College West" ] andRectangle:CGRectMake(188.0, 11.0, 96.0, 87.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"Dr. William Riddell Centre" ] andRectangle:CGRectMake(74.0, 46.0, 100.0, 100.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"South Residence" ] andRectangle:CGRectMake(221.0, 196.0, 56.0, 109.0)]];
	[locationsArray addObject:[[TouchLocator alloc]initWithName:[[NSMutableString alloc]initWithFormat:@"%@",@"North Residence" ] andRectangle:CGRectMake(294.0, 205.0, 52.0, 88.0)]];
	
	[self loadLocationsInfo];
	
	//Create an autoreleased image (taken from the Resources folder)
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	
	UIImage * largeImage = [UIImage imageNamed:@"Map2.png"];
	//Create a UIImageView with the image and set a property for later use
	UIImageView * tmpImageView = [[UIImageView alloc] initWithImage:largeImage];
	[tmpImageView addGestureRecognizer:gesture];
	tmpImageView.userInteractionEnabled = YES;
	tmpImageView.contentMode = UIViewContentModeScaleToFill;
	self.imageV = tmpImageView;
	[tmpImageView release];
	
	//We use the application frame as the size of our scrollViews frame (so we fill the usable part of the window)
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
	scrollV = [[UIScrollView alloc] initWithFrame:applicationFrame];
	//In order to use a scroll view we must set the content size
	scrollV.contentSize = largeImage.size;
	
	//In order to do "pinch" zomming, we need to set the min, max zoom and implement the delegate
	//   method viewForZoomingInScrollView
	scrollV.minimumZoomScale = 0.515;
	scrollV.maximumZoomScale = 5;
	scrollV.delegate = self;
	scrollV.bounces = YES;
	scrollV.bouncesZoom = NO;
	//Add the image view to our scroll view then set our view controllers view to our UIScrollView
	[scrollV addSubview:imageV];
	scrollV.zoomScale = 0.515;
	self.view = scrollV;
	
	//UIImageView *infoSign = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon_Info.gif"]];
	//infoSign.frame = legendButtonLocation;
	//[imageV addSubview:infoSign];
	//[infoSign release];
	
	if (locationsInfo != nil) {
		
		for (int i = 0 ; i < [locationsArray count]; i++) {
			int index = 0;
			while (![[[locationsInfo objectAtIndex:index] objectForKey:@"name"] isEqual:[[locationsArray objectAtIndex:i]name]]) {
				index++;
			}
		
			if ([[[locationsInfo objectAtIndex:index] objectForKey:@"event"] isEqual:@"yes"]) {
				UIImageView *temporary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"83-calendar-green.png"]];
				temporary.frame = CGRectMake([[locationsArray objectAtIndex:i] area].origin.x, [[locationsArray objectAtIndex:i] area].origin.y, 20, 20);
				[imageV addSubview:temporary];
				[temporary release];
			}
		
			if ([[[locationsInfo objectAtIndex:index] objectForKey:@"establishment"] isEqual:@"yes"]) {
				UIImageView *temporary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"48-fork-and-knife-red.png"]];
				temporary.frame = CGRectMake([[locationsArray objectAtIndex:i] area].origin.x + 20, [[locationsArray objectAtIndex:i] area].origin.y, 20, 20);
				[imageV addSubview:temporary];
				[temporary release];
			}
		
			if ([[[locationsInfo objectAtIndex:index] objectForKey:@"vmachine"] isEqual:@"yes"]) {
				UIImageView *temporary = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"142-wine-bottle-blue.png"]];
				temporary.frame = CGRectMake([[locationsArray objectAtIndex:i] area].origin.x, [[locationsArray objectAtIndex:i] area].origin.y + 20, 10, 20);
				[imageV addSubview:temporary];
				[temporary release];
			}
		
		}
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)tapped:(UITapGestureRecognizer*) recognizer {
	
	NSLog(@"is being called");	
	CGPoint point = [recognizer locationInView:self.imageV];
	NSLog(@"x = %f y = %f",point.x, point.y );
	
	if (CGRectContainsPoint(legendButtonLocation, point)) {
		LegendViewController *lvc = [[LegendViewController alloc] initWithNibName:@"LegendViewController" bundle:nil];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration: 1];
		
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
		[[self navigationController] pushViewController:lvc animated:NO];
		[UIView commitAnimations];
		
	}
	
	int index = 0;
	BOOL found = NO;
	while (index < [locationsArray count]) {
		if ([[locationsArray objectAtIndex:index] findIfThePointIsInsideTheRectangle:point]) {
			found = YES;
			break;
		}
		index++;
	}
	

	
	if (found) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		if ([self checkConnection]) {
			ShowInformationAccordingToLocation *showInfo = [[ShowInformationAccordingToLocation alloc] initWithNibName:@"ShowInformationAccordingToLocation" bundle:nil];
			showInfo.location = [NSMutableString stringWithFormat:@"%@", [[locationsArray objectAtIndex:index]name]];
			[self.navigationController pushViewController:showInfo animated:YES];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
	
}

-(BOOL) checkConnection {
	Reachability* reachability = [Reachability reachabilityWithHostName:@"www.myurlife.ca"];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	if (remoteHostStatus == NotReachable) { 
		NSLog(@"not connected.");
		return NO;
	} else {
		NSLog(@"connected.");
		return YES;
	}	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
