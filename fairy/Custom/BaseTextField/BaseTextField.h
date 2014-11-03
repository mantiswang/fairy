//
//  LYBaseTextField.h
//  Layou
//
//  Created by cydida on 14-4-24.
//  Copyright (c) 2014年 cydida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

@property(nonatomic,assign)BOOL isLeftViewPadding;
@property(nonatomic,assign)BOOL isRightViewPadding;
@property(nonatomic,assign)CGPoint rightOffset;
@property(nonatomic,assign)CGRect  leftBounds;

-(void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left;

@end
