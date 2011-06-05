//
//  WeatherStation.h
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeatherStation : NSObject {
	NSMutableData *receivedData;
	NSData *rawData;
	
	id updateDelegate;
	SEL updateDelegateCallback;
}

@property (retain) NSData *rawData;

- (void)fetchTheDataWithDelegate:(id)delegate callback:(SEL)callback;

@end
