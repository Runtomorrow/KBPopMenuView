//
//  KBPopMenuPath.h
//  KBPopMenuView
//
//  Created by kobe on 2017/8/2.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KBPopMenuArrowDirection){
    KBPopMenuArrowDirectionTop = 0,        ///< 箭头朝上
    KBPopMenuArrowDirectionBottom,         ///< 箭头朝下
    KBPopMenuArrowDirectionLeft,           ///< 箭头朝左
    KBPopMenuArrowDirectionRight,          ///< 箭头朝右
    KBPopMenuArrowDirectionNone            ///< 无箭头
};

@interface KBPopMenuPath : NSObject

+ (CAShapeLayer *)drawMaskLayerWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(KBPopMenuArrowDirection)arrowDirection;


+ (UIBezierPath *)drawBezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(KBPopMenuArrowDirection)arrowDirection
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor;

@end
