//
//  TempGraphViewController.h
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSDate.h>
#import "WeatherStation.h"

@interface TempGraphViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	WeatherStation *weatherStation;
	UITableView *table;
}

@property (retain) IBOutlet UITableView *table;

- (IBAction)showRawTempData;
- (void)updateDisplay;

@end

