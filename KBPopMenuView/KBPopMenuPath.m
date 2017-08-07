//
//  KBPopMenuPath.m
//  KBPopMenuView
//
//  Created by kobe on 2017/8/2.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import "KBPopMenuPath.h"
#import "KBRectConst.h"

@implementation KBPopMenuPath


+ (CAShapeLayer *)drawMaskLayerWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(KBPopMenuArrowDirection)arrowDirection{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self drawBezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection borderWidth:0 borderColor:nil backgroundColor:nil].CGPath;
    return shapeLayer;
    
}

+ (UIBezierPath *)drawBezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(KBPopMenuArrowDirection)arrowDirection
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    
    // 绘制矩形边框
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, KBRectWidth(rect) - borderWidth, KBRectHeight(rect) - borderWidth);
    CGFloat topRightRadius = 0, topLeftRadius = 0, bottomRightRadius = 0, bottomLeftRadius = 0;
    CGPoint topRightArcCenter, topLeftArcCenter, bottomRightArcCenter, bottomLeftArcCenter;
    
    if (rectCorner & UIRectCornerTopLeft) {
        topLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerTopRight) {
        topRightRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomLeft) {
        bottomLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomRight) {
        bottomRightRadius = cornerRadius;
    }
    
    if (arrowDirection == KBPopMenuArrowDirectionTop) {
        
        // 确定四个圆角的中心位置点
        topLeftArcCenter = CGPointMake(topLeftRadius + KBRectX(rect), arrowHeight + topLeftRadius + KBRectY(rect));
        topRightArcCenter = CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), arrowHeight + topRightRadius + KBRectY(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect)- bottomLeftRadius + KBRectY(rect));
        bottomRightArcCenter = CGPointMake(KBRectWidth(rect) - bottomRightRadius + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect));
        
        
        // 箭头距离左边的最小位置 箭头距离右边的最大位置
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }
        else if (arrowPosition > KBRectWidth(rect) - topRightRadius - arrowWidth / 2){
            arrowPosition = KBRectWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        
        
        // 绘制路径
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + KBRectY(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, KBRectTop(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + KBRectY(rect))];
        
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - topRightRadius, arrowHeight + KBRectY(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect) + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect), arrowHeight + topLeftRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    }else if (arrowDirection == KBPopMenuArrowDirectionBottom){
        
        // 确定四个圆角的中心位置点
        topLeftArcCenter = CGPointMake(topLeftRadius + KBRectX(rect), topLeftRadius + KBRectY(rect));
        topRightArcCenter = CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), topRightRadius + KBRectY(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect)- bottomLeftRadius + KBRectY(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(KBRectWidth(rect) - bottomRightRadius + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect) - arrowHeight);
        
        
        // 箭头距离左边的最小位置 箭头距离右边的最大位置
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        }
        else if (arrowPosition > KBRectWidth(rect) - bottomRightRadius - arrowWidth / 2){
            arrowPosition = KBRectWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        
        // 绘制路径
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, KBRectHeight(rect) - arrowHeight + KBRectY(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, KBRectBottom(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, KBRectHeight(rect) - arrowHeight + KBRectY(rect))];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect) + bottomLeftRadius, KBRectHeight(rect) - arrowHeight + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect), topLeftRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), KBRectY(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius - arrowHeight + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    }else if (arrowDirection == KBPopMenuArrowDirectionLeft){
        
        // 确定四个圆角的中心位置点
        topLeftArcCenter = CGPointMake(topLeftRadius + KBRectX(rect) + arrowHeight, topLeftRadius + KBRectY(rect));
        topRightArcCenter = CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), topRightRadius + KBRectY(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + KBRectX(rect) + arrowHeight, KBRectHeight(rect)- bottomLeftRadius + KBRectY(rect));
        bottomRightArcCenter = CGPointMake(KBRectWidth(rect) - bottomRightRadius + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect));
        
        
        // 箭头距离左边的最小位置 箭头距离右边的最大位置
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }
        else if (arrowPosition > KBRectHeight(rect) - bottomLeftRadius - arrowWidth / 2){
            arrowPosition = KBRectHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        
        // 绘制路径
        [bezierPath moveToPoint:CGPointMake(arrowHeight + KBRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + KBRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + KBRectX(rect), topLeftRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), KBRectY(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + KBRectX(rect), KBRectHeight(rect) + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }else if (arrowDirection == KBPopMenuArrowDirectionRight){
        
        // 确定四个圆角的中心位置点
        topLeftArcCenter = CGPointMake(topLeftRadius + KBRectX(rect), topLeftRadius + KBRectY(rect));
        topRightArcCenter = CGPointMake(KBRectWidth(rect) - topRightRadius - arrowHeight + KBRectX(rect), topRightRadius + KBRectY(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect)- bottomLeftRadius + KBRectY(rect));
        bottomRightArcCenter = CGPointMake(KBRectWidth(rect) - bottomRightRadius - arrowHeight + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect));
        
        
        // 箭头距离左边的最小位置 箭头距离右边的最大位置
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        }
        else if (arrowPosition > KBRectHeight(rect) - bottomRightRadius - arrowWidth / 2){
            arrowPosition = KBRectHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        
        // 绘制路径
        [bezierPath moveToPoint:CGPointMake(KBRectWidth(rect) - arrowHeight + KBRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) + KBRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - arrowHeight + KBRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - arrowHeight + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect) + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect), topLeftRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - arrowHeight - topRightRadius + KBRectX(rect), KBRectY(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
    }else if (arrowDirection == KBPopMenuArrowDirectionNone){
        
        // 确定四个圆角的中心位置点
        topLeftArcCenter = CGPointMake(topLeftRadius + KBRectX(rect), topLeftRadius + KBRectY(rect));
        topRightArcCenter = CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), topRightRadius + KBRectY(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + KBRectX(rect), KBRectHeight(rect)- bottomLeftRadius + KBRectY(rect));
        bottomRightArcCenter = CGPointMake(KBRectWidth(rect) - bottomRightRadius + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect));
        
        // 绘制路径
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + KBRectX(rect), KBRectY(rect))];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) - topRightRadius + KBRectX(rect), KBRectY(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectWidth(rect) + KBRectX(rect), KBRectHeight(rect) - bottomRightRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect) + bottomLeftRadius, KBRectHeight(rect) + KBRectY(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(KBRectX(rect), topLeftRadius + KBRectY(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];

    }
    
    [bezierPath closePath];
    return bezierPath;
    
}

@end





































































