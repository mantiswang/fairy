//
//  NSDictionary+Json.h
//  fairy
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(Json)
-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end
