//
//  TempGraphViewController.m
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "TempGraphViewController.h"

@interface TempGraphViewController()
@property (retain) WeatherStation *weatherStation;
@end

@implementation TempGraphViewController

@synthesize weatherStation;
@synthesize display;

- (WeatherStation *)weatherStation
{
	if (!weatherStation) {
		weatherStation = [[WeatherStation alloc] init];
	}
	return weatherStation;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)showRawTempData
{
	[self.weatherStation fetchTheData];
	
	while (YES) {
		self.display.text = [[NSString alloc] initWithData:weatherStation.rawData];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)releaseOutlets
{
	self.weatherStation = nil;
	self.display = nil;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self releaseOutlets];
}


- (void)dealloc {
	[self releaseOutlets];
    [super dealloc];
}

@end
