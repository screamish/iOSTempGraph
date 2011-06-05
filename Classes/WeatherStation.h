//
//  WeatherStation.h
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"


@interface WeatherStation : NSObject {
	NSMutableData *receivedData;
	NSData *rawData;
	
	NSData *mockData;
	
	NSDictionary *parsedData;
	
	NSArray *temperatures;
	NSArray *timestamps;
	
	id updateDelegate;
	SEL updateDelegateCallback;
}

@property (retain) NSData *rawData;
@property (retain) NSDictionary *parsedData;
@property (retain) NSArray *temperatures;
@property (retain) NSArray *timestamps;

- (void)fetchTheDataWithDelegate:(id)delegate callback:(SEL)callback;

@end
