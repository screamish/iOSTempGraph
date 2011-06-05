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
	BOOL dataFinishedDownloading;
	NSData *rawData;
}

@property (retain) NSData *rawData;

- (void)fetchTheData;

@end
