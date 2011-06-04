//
//  TempGraphAppDelegate.h
//  TempGraph
//
//  Created by Simon Fenton on 4/06/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TempGraphViewController;

@interface TempGraphAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TempGraphViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TempGraphViewController *viewController;

@end

