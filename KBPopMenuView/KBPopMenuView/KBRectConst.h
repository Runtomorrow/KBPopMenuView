//
//  KBRectConst.h
//  KBPopMenuView
//
//  Created by kobe on 2017/8/1.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 获取矩形的宽度

 @param rect rect
 @return 返回矩形的宽度
 */
UIKIT_STATIC_INLINE CGFloat KBRectWidth(CGRect rect){
    return rect.size.width;
}

/**
 获取矩形的高度

 @param rect rect
 @return 返回矩形的高度
 */
UIKIT_STATIC_INLINE CGFloat KBRectHeight(CGRect rect){
    return rect.size.height;
}


/**
 获取矩形的起始位置X

 @param rect rect
 @return 返回矩形的起始X坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectX(CGRect rect){
    return rect.origin.x;
}


/**
 获取矩形的起始位置Y

 @param rect rect
 @return 返回矩形起始Y坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectY(CGRect rect){
    return rect.origin.y;
}


/**
 获取矩形的起始Y坐标
 
 @param rect rect
 @return 返回矩形的起始Y坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectTop(CGRect rect){
    return rect.origin.y;
}


/**
 获取矩形底部Y坐标

 @param rect rect
 @return 返回矩形的底部Y坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectBottom(CGRect rect){
    return rect.origin.y + rect.size.height;
}


/**
 获取矩形的起始X坐标

 @param rect rect
 @return 返回矩形的起始X坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectLeft(CGRect rect){
    return rect.origin.x;
}


/**
 获取矩形的右边X坐标

 @param rect rect
 @return 返回矩形的右边X坐标
 */
UIKIT_STATIC_INLINE CGFloat KBRectRight(CGRect rect){
    return rect.origin.x + rect.size.width;
}
