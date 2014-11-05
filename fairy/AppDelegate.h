//
//  AppDelegate.h
//  fairy
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) CLLocationCoordinate2D location;

@end

