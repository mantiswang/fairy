//
//  Define.h
//  fairy
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#ifndef fairy_Define_h
#define fairy_Define_h



#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]



#define COLOR_PLACE_HOLDER         ([UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f])
#define BACKGROUND_COLOR           ([UIColor colorWithRed:240/255.0f green:237/255.0f blue:245/255.0f alpha:1.0f])
#define MAIN_BLUE_COLOR            ([UIColor colorWithRed:147/255.0f green:64/255.0f blue:196/255.0f alpha:1.0f])


#define FAIRY_DEBUG
#ifdef FAIRY_DEBUG

    #define HOST @"http://192.168.1.118:8080/alone"

#else

    #define HOST @""

#endif

#define API_AUTHPATH   @"/api/dashboard"


#endif
