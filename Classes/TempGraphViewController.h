//
//  TempGraphViewController.h
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherStation.h"

@interface TempGraphViewController : UIViewController {
	WeatherStation *weatherStation;
	IBOutlet UILabel *display;
}

@property (retain) IBOutlet UILabel *display;

- (IBAction)showRawTempData;
- (void)updateDisplay;

@end

