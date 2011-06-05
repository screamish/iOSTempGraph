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
@synthesize table;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.weatherStation.temperatures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if (nil == cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	
	if (nil != [self.weatherStation.temperatures objectAtIndex:row])
	{
		//TODO put this back when I work out how to parse the date data we have
		//TODO move this all out of here and into the WeatherStation, this is NASTY
		/*
		NSTimeInterval timeInterval;
		NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
		[numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		
		timeInterval = [[numFormatter numberFromString:[self.weatherStation.timestamps objectAtIndex:row]] doubleValue];
		
		NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		
		NSString *timeAsText = [dateFormatter stringFromDate:tempDate];
		*/
		
		NSString *timeAsText = [self.weatherStation.timestamps objectAtIndex:row];
		
		cell.textLabel.text = [timeAsText stringByAppendingFormat:@" %@ Celcius", [self.weatherStation.temperatures objectAtIndex:row]];
		//cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.weatherStation.temperatures objectAtIndex:row]];
		
		//[numFormatter release];
		//[tempDate release];
		//[dateFormatter release];
	}
	else {
		cell.textLabel.text = @"Empty";
	}

	
	return cell;
}

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

- (void)updateDisplay
{
	// self.display.text = [[NSString alloc] initWithData:weatherStation.rawData encoding:NSUTF8StringEncoding];
	[self.table reloadData];
}

- (IBAction)showRawTempData
{
	[self.weatherStation fetchTheDataWithDelegate:self callback:@selector(updateDisplay)];
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
	self.table = nil;
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
