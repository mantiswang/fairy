//
//  AppDelegate.m
//  fairy
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#import "AppDelegate.h"
#import "MMLocationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getLocation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)getLocation
{
    if(locationManager==nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [[MMLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        NSDictionary *dic = @{@"lat":[NSNumber numberWithFloat:locationCorrrdinate.latitude],@"lng":[NSNumber numberWithFloat:locationCorrrdinate.longitude]};

        self.location = locationCorrrdinate;
        
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"location"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    } withAddress:^(NSString *addressString) {
        [[NSUserDefaults standardUserDefaults] setObject:addressString forKey:@"city"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"%@", addressString);
    }];
    
//        [[MMLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate)
//     {
//         
//         NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:locationCorrrdinate.latitude],Latitude,[NSNumber numberWithFloat:locationCorrrdinate.longitude],Longitude,nil];
//         [[NSUserDefaults standardUserDefaults] setObject:dic forKey:LocationCoordinate2D];
//         [[NSUserDefaults standardUserDefaults] synchronize];
//         
//     }
//                                                      error:^(NSString *errorStr)
//     {
//         //提示用户无法进行定位操作
//         UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"提示"
//                                                           message:errorStr
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"确定"
//                                                 otherButtonTitles:nil, nil];
//         [alertView show];
//     }];
    
}


@end
