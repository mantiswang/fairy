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
    
    [self registerNotificaiton];

    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(78, 188, 211, 1)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    }
    
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ywang#sandbox" apnsCertName:apnsCertName];
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
#warning autoFetchBuddyList 取消了
//    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#warning 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
#warning 如果使用MagicalRecord, 要加上这句初始化MagicalRecord
    //demo coredata, .pch中有相关头文件引用
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"UIDemo"]];
    
    return YES;
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


-(void)registerNotificaiton
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    [self registerRemoteNotification];

    
}

- (void)registerRemoteNotification{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    if (_mainController) {
//        [_mainController jumpToChatList];
//    }
    
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    if (_mainController) {
//        [_mainController jumpToChatList];
//    }
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidEnterBackground" object:nil];
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}





#pragma mark - private
-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    UIViewController *mainController;
    
    if (isAutoLogin || loginSuccess) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        mainController = [storyboard instantiateInitialViewController];
        
        
//        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
//        if (_mainController == nil) {
//            _mainController = [[MainViewController alloc] init];
//            nav = [[UINavigationController alloc] initWithRootViewController:_mainController];
//        }else{
//            nav  = _mainController.navigationController;
//        }
    }else{
//        _mainController = nil;
//        LoginViewController *loginController = [[LoginViewController alloc] init];
//        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
//        loginController.title = @"环信Demo";
    }
//    
//    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
//        nav.navigationBar.barStyle = UIBarStyleDefault;
//        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
//                                forBarMetrics:UIBarMetricsDefault];
//        
//        [nav.navigationBar.layer setMasksToBounds:YES];
//    }
    
    self.window.rootViewController = mainController;
    
//    [nav setNavigationBarHidden:YES];
//    [nav setNavigationBarHidden:NO];
}

@end
