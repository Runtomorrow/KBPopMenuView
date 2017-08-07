//
//  KBPopMenuView.h
//  KBPopMenuView
//
//  Created by kobe on 2017/7/31.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBPopMenuPath.h"

typedef NS_ENUM(NSInteger, KBPopMenuPriorityArrowDirection){
    KBPopMenuPriorityArrowDirectionTop = 0,
    KBPopMenuPriorityArrowDirectionBottom,
    KBPopMenuPriorityArrowDirectionLeft,
    KBPopMenuPriorityArrowDirectionRight,
    KBPopMenuPriorityArrowDirectionNone       ///< 不自动调整
};

@interface KBPopMenuView : UIView

/** 箭头的宽度 */
@property (nonatomic, assign) CGFloat arrowWidth;
/** 箭头的高度 */
@property (nonatomic, assign) CGFloat arrowHeight;
/** 箭头在菜单的X轴方向 */
@property (nonatomic, assign) CGFloat arrowPosition;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;
/** 线条的边框宽度 */
@property (nonatomic, assign) CGFloat borderWidth;
/** 箭头的偏移距离 */
@property (nonatomic, assign) CGFloat offset;
/** 圆角 */
@property (nonatomic, assign) UIRectCorner rectCorner;
/** 需要显示的视图 */
@property (nonatomic, strong, nullable) UIView *contentView;
/** 需要显示的控制器 */
@property (nonatomic, strong, nullable) UIViewController *contentVC;
/** 箭头方向的优先级别 */
@property (nonatomic, assign) KBPopMenuPriorityArrowDirection priorityArrowDirection;
/** 箭头的指示方向 */
@property (nonatomic, assign) KBPopMenuArrowDirection arrowDirection;

/**
 通过某个点显示下拉菜单

 @param atPoint point
 @return 自身对象
 */
+ (KBPopMenuView *_Nullable)showMenuAtPoint:(CGPoint)atPoint viewSize:(CGSize)size;


/**
 依赖某个视图空间显示下拉菜单

 @param view view
 @return 自身对象
 */
+ (KBPopMenuView *_Nullable)showMenuRelyOnView:(UIView *_Nullable)view viewSize:(CGSize)size;

@end
