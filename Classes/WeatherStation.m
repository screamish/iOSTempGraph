//
//  WeatherStation.m
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "WeatherStation.h"


@implementation WeatherStation

@synthesize rawData;
@synthesize parsedData;

@synthesize temperatures, timestamps;


- (NSData *)mockData
{
	if (!mockData) {
		mockData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"IDV6090194868" ofType:@"jsn"]];
	}
	return mockData;
}

- (void) beginFetchFromBOM {
	// Create the request.
	NSURL *melbourneJSONData = [NSURL URLWithString:@"http://www.bom.gov.au/fwo/IDV60901/IDV60901.94868.json"];
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:melbourneJSONData
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:20.0];
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		// Create the NSMutableData to hold the received data.
		// receivedData is an instance variable declared elsewhere.
		receivedData = [[NSMutableData data] retain];
	} else {
		// Inform the user that the connection failed.
	}

}

- (NSDictionary *)parseJSONData:(NSData *)jsonData
{
	NSDictionary *theJSONData = nil;
	NSError *theError = nil;
	id theObject = [[CJSONDeserializer deserializer] deserialize:jsonData error:&theError];
	
	if ([theObject isKindOfClass:[NSDictionary class]]) {
		theJSONData = theObject;
		NSDictionary *observations = [theJSONData objectForKey:@"observations"];
		NSDictionary *innerData = [observations objectForKey:@"data"];
		self.temperatures = [innerData objectForKey:@"air_temp"];
		//self.timestamps = [innerData objectForKey:@"local_date_time_full"];
		self.timestamps = [innerData objectForKey:@"local_date_time"];
	}
	
	return theJSONData;
}

- (void)fetchTheDataWithDelegate:(id)delegate callback:(SEL)callback
{
	// Set the delegate and callback for passing back the data
	updateDelegate = [delegate retain];
	updateDelegateCallback = callback;
	
	// Uncomment the below to fetch the fresh data, but for now we use the mock data
	//[self beginFetchFromBOM];
	
	// TODO remove the below when we no longer need the fake
	self.rawData = [[NSData alloc] initWithData:self.mockData];
	
	self.parsedData = [self parseJSONData:self.rawData];
	
	[updateDelegate performSelector:updateDelegateCallback];
	
	// release the update delegate
	[updateDelegate release];	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	
	self.rawData = [[NSData alloc] initWithData:receivedData];
	
	[updateDelegate performSelector:updateDelegateCallback];
	
    // release the connection, and the data object
    [connection release];
    [receivedData release];
	
	// release the update delegate
	[updateDelegate release];
}



- (void)dealloc {
	self.rawData = nil;
    [super dealloc];
}


@end
