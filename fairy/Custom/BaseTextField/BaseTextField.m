//
//  LYBaseTextField.m
//  Layou
//
//  Created by cydida on 14-4-24.
//  Copyright (c) 2014年 cydida. All rights reserved.
//

#import "BaseTextField.h"

@interface BaseTextField()
{
    BOOL isEnablePadding;
    float paddingLeft;
    float paddingRight;
    float paddingTop;
    float paddingBottom;
}
@end

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isLeftViewPadding  = NO;
        _isRightViewPadding = NO;
    }
    return self;
}

#pragma mark - 
#pragma mark 禁用TextField的拷贝、粘贴等菜单
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

-(void)setFrame:(CGRect)frame
{
    _isLeftViewPadding = NO;
    [super setFrame:frame];
}

- (void)setPadding:(BOOL)enable top:(float)top right:(float)right bottom:(float)bottom left:(float)left
{
    isEnablePadding = enable;
    paddingTop = top;
    paddingRight = right;
    paddingBottom = bottom;
    paddingLeft = left;
    
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    if (isEnablePadding)
    {
        if (_isRightViewPadding)
        {
            return CGRectMake(bounds.origin.x + paddingLeft,
                              bounds.origin.y + paddingTop,
                              bounds.size.width - paddingRight - self.rightView.bounds.size.width, bounds.size.height - paddingBottom);
        }
        else
        {
            return CGRectMake(bounds.origin.x + paddingLeft,
                              bounds.origin.y + paddingTop,
                              bounds.size.width - paddingRight, bounds.size.height - paddingBottom);
        }
    }
    else
    {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    if (_isLeftViewPadding)
    {
        return CGRectMake(bounds.origin.x + _leftBounds.origin.x, bounds.origin.y + _leftBounds.origin.y,
                          _leftBounds.size.width,_leftBounds.size.height);
    }
    return self.leftView.bounds;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    if (_isRightViewPadding)
    {
        return CGRectMake(bounds.origin.x + _rightOffset.x, bounds.origin.y + _rightOffset.y,
                          bounds.size.width - _rightOffset.x,bounds.size.height);
//        return CGRectMake(bounds.origin.x + 165, bounds.origin.y + 2.5, bounds.size.width -165,bounds.size.height);
    }
    return self.rightView.bounds;
}

//- (CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    if (self.clearButtonMode) {
//        
//    }
//    return CGRectMake(bounds.origin.x + 177, bounds.origin.y + 5, bounds.size.width - 177,bounds.size.height);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
