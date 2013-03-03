//
//  EventFeedback.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-03.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowEventInformationController.h"
#import "ShowEstablishmentInformationController.h"
#import "ShowVMachineInformationController.h"

/**
 It handles the feedbacks for events/establishments/vmachines.
 */
@interface EventFeedback : UIViewController {
	/**
	 It holds an instance of the last view if it is an event
	 */
	ShowEventInformationController *showEvent;
	/**
	 It holds an instance of the last view if it is an establishment
	 */
	ShowEstablishmentInformationController *showEstablishment;
	/**
	 It holds an instance of the last view if it is a vending machine
	 */
	ShowVMachineInformationController *showVendingMachine;
	/**
	 Event ID if it is for event
	 */
	NSMutableString *eventID;
	/**
	 Establishment ID if it is for establishment
	 */
	NSMutableString *establishmentID;
	/**
	 VMachine ID if it is for vending machine
	 */
	NSMutableString *vMachineID;
	/**
	 The textfield for the comment
	 */
	IBOutlet UITextField *commentTextfield;
	/**
	 The textfield for the username
	 */
	IBOutlet UITextField *nameTextfield;
	/**
	 The textfield for the password
	 */
	IBOutlet UITextField *passwordTextfield;
}

@property (nonatomic, retain) ShowEventInformationController *showEvent;
@property (nonatomic, retain) ShowEstablishmentInformationController *showEstablishment;
@property (nonatomic, retain) ShowVMachineInformationController *showVendingMachine;
@property (nonatomic, retain) NSMutableString *eventID;
@property (nonatomic, retain) NSMutableString *establishmentID;
@property (nonatomic, retain) NSMutableString *vMachineID;
@property (nonatomic, retain) IBOutlet UITextField *commentTextfield;
@property (nonatomic, retain) IBOutlet UITextField *nameTextfield;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextfield;

/**
 It posts the comment when the submit button is pressed.
 */
-(IBAction) submitButtonPressed:(id)sender;
/**
 It hides the keyboard when the backgound is tapped.
 */
-(IBAction) backgroundClick:(id)sender;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;
@end
