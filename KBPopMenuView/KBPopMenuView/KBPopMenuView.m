//
//  KBPopMenuView.m
//  KBPopMenuView
//
//  Created by kobe on 2017/7/31.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import "KBPopMenuView.h"
#import "KBPopMenuPath.h"

#define KBMainWindow  [UIApplication sharedApplication].keyWindow
#define KBScreenWidth [UIScreen mainScreen].bounds.size.width
#define KBScreenHight [UIScreen mainScreen].bounds.size.height
#define kMinSpace 10



@interface KBPopMenuView ()

@property (nonatomic, assign) CGPoint atPoint;
@property (nonatomic, assign) CGRect relyRect;
@property (nonatomic, strong, nullable) UIView *menuBackgroundView;
@property (nonatomic, assign) BOOL isChangeArrowDirection;
@property (nonatomic, assign) BOOL isChangeCorner;

@end

@implementation KBPopMenuView

- (UIView *)menuBackgroundView{
    if (!_menuBackgroundView) {
        _menuBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KBScreenWidth, KBScreenHight)];
        _menuBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _menuBackgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)];
        [_menuBackgroundView addGestureRecognizer:tap];
        
    }
    return _menuBackgroundView;
}

- (instancetype)init{
    if (self = [super init]) {
        [self defaultParams];
    }
    return self;
}


+ (KBPopMenuView *)showMenuAtPoint:(CGPoint)atPoint viewSize:(CGSize)size{
    KBPopMenuView *kBPopMenuView = [[KBPopMenuView alloc] init];
    kBPopMenuView.atPoint = atPoint;
    kBPopMenuView.itemWidth = size.width;
    kBPopMenuView.itemHeight = size.height;
    [kBPopMenuView showMenu];
    return kBPopMenuView;
}

+ (KBPopMenuView *)showMenuRelyOnView:(UIView *)view viewSize:(CGSize)size{
    CGRect absoluteRect = [view convertRect:view.bounds toView:KBMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x, absoluteRect.origin.y + absoluteRect.size.height);
    KBPopMenuView *kBPopMenuView = [[KBPopMenuView alloc] init];
    kBPopMenuView.atPoint = relyPoint;
    kBPopMenuView.relyRect = absoluteRect;
    kBPopMenuView.itemWidth = size.width;
    kBPopMenuView.itemHeight = size.height;
    [kBPopMenuView showMenu];
    return kBPopMenuView;
}


- (void)showMenu{
    
    [KBMainWindow addSubview:self.menuBackgroundView];
    [KBMainWindow addSubview:self];
    
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        _menuBackgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)dismissMenu{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        _menuBackgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [_menuBackgroundView removeFromSuperview];
    }];
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [KBPopMenuPath drawBezierPathWithRect:rect rectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight cornerRadius: 2.0f arrowWidth:_arrowWidth arrowHeight:_arrowHeight arrowPosition:_arrowPosition arrowDirection:_arrowDirection borderWidth:_borderWidth borderColor:[UIColor whiteColor] backgroundColor:[UIColor whiteColor]];
    [path fill];
    [path stroke];
}


#pragma mark - Private Method
- (void)removeBackgroundViewAction:(UIGestureRecognizer *)gesture{
    
    [_menuBackgroundView removeFromSuperview];
    
    [self removeFromSuperview];
}


- (void)defaultParams{
    
    self.backgroundColor = [UIColor clearColor];
    self.atPoint = CGPointZero;
    self.isChangeArrowDirection = NO;
    self.isChangeCorner = NO;
    
    _itemWidth = 110;
    _itemHeight = 44;
    _borderWidth = 2;
    _arrowHeight = 5;
    _arrowWidth = 10;
    _arrowPosition = 50;
    _arrowDirection = KBPopMenuArrowDirectionTop;
    _priorityArrowDirection = KBPopMenuPriorityArrowDirectionTop;
}


- (void)dealUpdateUI{
    
    // 计算不包含箭头的高度和宽度
    CGFloat frameH = _itemHeight + _borderWidth * 2;
    CGFloat frameW = _itemWidth + _borderWidth * 2;
    
    
    // 自动改变箭头的指示方向
    _isChangeArrowDirection = NO;
    if (_priorityArrowDirection == KBPopMenuPriorityArrowDirectionTop) {
        if (_atPoint.y + frameH + _arrowHeight > KBScreenHight - kMinSpace) {
            _arrowDirection = KBPopMenuArrowDirectionBottom;
            _isChangeArrowDirection = YES;
        }else{
            _arrowDirection = KBPopMenuArrowDirectionTop;
            _isChangeArrowDirection = NO;
        }
    }else if (_priorityArrowDirection == KBPopMenuPriorityArrowDirectionBottom){
        if (_atPoint.y - frameH - _arrowHeight < kMinSpace) {
            _arrowDirection = KBPopMenuArrowDirectionTop;
            _isChangeArrowDirection = YES;
        }else{
            _arrowDirection = KBPopMenuArrowDirectionBottom;
            _isChangeArrowDirection = NO;
        }
    }else if (_priorityArrowDirection == KBPopMenuPriorityArrowDirectionLeft){
        if (_atPoint.x + frameW + _arrowHeight > KBScreenWidth - kMinSpace) {
            _arrowDirection = KBPopMenuArrowDirectionRight;
            _isChangeArrowDirection = YES;
        }else{
            _arrowDirection = KBPopMenuArrowDirectionLeft;
            _isChangeArrowDirection = NO;
        }
    }else if (_priorityArrowDirection == KBPopMenuPriorityArrowDirectionRight){
        
        if (_atPoint.x - frameW - _arrowHeight < kMinSpace) {
            _arrowDirection = KBPopMenuArrowDirectionLeft;
            _isChangeArrowDirection = YES;
        }else{
            _arrowDirection = KBPopMenuArrowDirectionRight;
            _isChangeArrowDirection = NO;
        }
    }
    
    
    [self dealArrowPosition];
    [self dealRelyRect];
    
    
    // 设置frame的位置
    if (_arrowDirection == KBPopMenuArrowDirectionTop) {
        CGFloat y = _isChangeArrowDirection ? _atPoint.y : _atPoint.y;
        // 箭头右边显示
        if (_arrowPosition > _itemWidth / 2 + _borderWidth) {
            self.frame = CGRectMake(KBScreenWidth - kMinSpace - frameW, y, frameW, frameH + _arrowHeight);
        }else if (_arrowPosition < _itemWidth / 2 + _borderWidth){
            // 箭头左边显示
            self.frame = CGRectMake(kMinSpace, y, frameW, frameH + _arrowHeight);
        }else{
            // 箭头居中显示
            self.frame = CGRectMake(_atPoint.x - frameW / 2, y, frameW, frameH + _arrowHeight);
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionBottom){
        CGFloat y = _isChangeArrowDirection ? _atPoint.y - _arrowHeight - frameH : _atPoint.y - _arrowHeight - frameH;
        // 箭头右边显示
        if (_arrowPosition > _itemWidth / 2 + _borderWidth) {
            self.frame = CGRectMake(KBScreenWidth - kMinSpace - frameW, y, frameW, frameH + _arrowHeight);
        }else if (_arrowPosition < _itemWidth / 2 + _borderWidth){
            // 箭头左边显示
            self.frame = CGRectMake(kMinSpace, y, frameW, frameH + _arrowHeight);
        }else{
            // 箭头居中显示
            self.frame = CGRectMake(_atPoint.x - frameW / 2, y, frameW, frameH + _arrowHeight);
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft){
        CGFloat x = _isChangeArrowDirection ? _atPoint.x : _atPoint.x;
        if (_arrowPosition < _itemHeight / 2) {
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }else if (_arrowPosition > _itemHeight / 2){
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }else{
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionRight){
        CGFloat x = _isChangeArrowDirection ? _atPoint.x - frameW - _arrowHeight : _atPoint.x - frameW -_arrowHeight;
        if (_arrowPosition < _itemHeight / 2 + _borderWidth) {
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }else if (_arrowPosition > _itemHeight / 2 + _borderWidth){
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }else{
            self.frame = CGRectMake(x, _atPoint.y - _arrowPosition, frameW + _arrowHeight, frameH);
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionNone){}
    
    if (_isChangeArrowDirection) {
        [self dealRectCorner];
    }
    [self dealAnchorPoint];
    [self dealOffset];
    [self setNeedsDisplay];
}


// 设置需要显示内容的Frame
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_arrowDirection == KBPopMenuArrowDirectionTop) {
        _contentView.frame = CGRectMake(_borderWidth, _borderWidth + _arrowHeight, _itemWidth, _itemHeight);
    }else if (_arrowDirection == KBPopMenuArrowDirectionBottom) {
        _contentView.frame = CGRectMake(_borderWidth, _borderWidth, _itemWidth, _itemHeight);
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft){
        _contentView.frame = CGRectMake(_borderWidth + _arrowHeight, _borderWidth, _itemWidth, _itemHeight);
    }else if (_arrowDirection == KBPopMenuArrowDirectionRight){
        _contentView.frame = CGRectMake(_borderWidth, _borderWidth, _itemWidth, _itemHeight);
    }
}


// 设置箭头相对菜单的的位置
- (void)dealArrowPosition{
    
    CGFloat frameW = _itemWidth + 2 * _borderWidth;
    
    if (_priorityArrowDirection == KBPopMenuPriorityArrowDirectionNone) return;
    if (_arrowDirection == KBPopMenuArrowDirectionTop || _arrowDirection == KBPopMenuArrowDirectionBottom) {
        // 箭头在Menu上的坐标位置 最右边
        if (_atPoint.x + frameW / 2 > KBScreenWidth - kMinSpace) {
            _arrowPosition = _itemWidth + _borderWidth - (KBScreenWidth - kMinSpace - _atPoint.x) - _borderWidth / 2;
        }else if (_atPoint.x < frameW / 2 + kMinSpace){
            // 箭头在Menu上的坐标位置 最左边
            _arrowPosition = _atPoint.x - kMinSpace - _borderWidth / 2;
        }else{
            // 箭头在Menu上的坐标位置 居中
            _arrowPosition = _itemWidth / 2 + _borderWidth;
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft || _arrowDirection == KBPopMenuArrowDirectionRight){
//        if (_atPoint.y +_itemHeight / 2 > KBScreenHight - kMinSpace) {
//            _arrowPosition = _itemHeight - (KBScreenHight - kMinSpace - _atPoint.y);
//        }else if (_atPoint.y < _itemHeight / 2 + kMinSpace){
//            _arrowPosition = _atPoint.y - kMinSpace;
//        }else{
//            _arrowPosition = _itemHeight / 2;
//        }
    }
}


- (void)dealRelyRect{
    if (CGRectEqualToRect(_relyRect, CGRectZero)) return;
    if (_arrowDirection == KBPopMenuArrowDirectionTop) {
        _atPoint.y = _relyRect.size.height + _relyRect.origin.y;
    }else if (_arrowDirection == KBPopMenuArrowDirectionBottom){
        _atPoint.y = _relyRect.origin.y;
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft){
        _atPoint = CGPointMake(_relyRect.origin.x + _relyRect.size.width, _relyRect.origin.y +_relyRect.size.height / 2);
    }else{
        _atPoint = CGPointMake(_relyRect.origin.x, _relyRect.origin.y + _relyRect.size.height / 2);
    }
}

- (void)dealAnchorPoint{
    
    if (_itemWidth == 0) return;
    CGPoint point = CGPointMake(0.5, 0.5);
    if (_arrowDirection == KBPopMenuArrowDirectionTop) {
        point = CGPointMake(_arrowPosition / (_itemWidth + _borderWidth), 0);
    }else if (_arrowDirection == KBPopMenuArrowDirectionBottom){
        point = CGPointMake(_arrowPosition / (_itemWidth + _borderWidth), 1);
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft){
        point = CGPointMake(0, ((_itemHeight + _borderWidth) - _arrowPosition) / (_itemHeight + _borderWidth));
    }else if (_arrowDirection == KBPopMenuArrowDirectionRight){
        point = CGPointMake(1, ((_itemHeight + _borderWidth) - _arrowPosition) / (_itemHeight + _borderWidth));
    }
    CGRect originRect = self.frame;
    self.layer.anchorPoint = point;
    self.frame = originRect;
}


- (void)dealOffset{
    if (_itemWidth == 0) return;
    CGRect originRect = self.frame;
    if (_arrowDirection == KBPopMenuArrowDirectionTop) {
        originRect.origin.y += _offset;
    }else if (_arrowDirection == KBPopMenuArrowDirectionBottom){
        originRect.origin.y -= _offset;
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft){
        originRect.origin.x += _offset;
    }else if (_arrowDirection == KBPopMenuArrowDirectionRight){
        originRect.origin.x -= _offset;
    }
    self.frame = originRect;
}


- (void)dealRectCorner{
    if (_isChangeCorner || _rectCorner == UIRectCornerAllCorners) return;
    BOOL haveTopLeftCorner = NO, haveTopRightCorner = NO, haveBottomLeftCorner = NO, haveBottomRightCorner = NO;
    if (_rectCorner & UIRectCornerTopLeft) {
        haveTopLeftCorner = YES;
    }
    if (_rectCorner & UIRectCornerTopRight) {
        haveTopRightCorner = YES;
    }
    if (_rectCorner & UIRectCornerBottomLeft) {
        haveBottomLeftCorner = YES;
    }
    if (_rectCorner & UIRectCornerBottomRight) {
        haveBottomRightCorner = YES;
    }
    if (_arrowDirection == KBPopMenuArrowDirectionTop || _arrowDirection == KBPopMenuArrowDirectionBottom) {
        if (haveTopLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomLeft;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerBottomLeft);
        }
        if (haveTopRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomRight;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerBottomRight);
        }
        if (haveBottomLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopLeft;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerTopLeft);
        }
        if (haveBottomRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopRight;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerTopRight);
        }
    }else if (_arrowDirection == KBPopMenuArrowDirectionLeft || _arrowDirection == KBPopMenuArrowDirectionRight){
        if (haveTopLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopRight;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerTopRight);
        }
        if (haveTopRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerTopLeft;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerTopLeft);
        }
        if (haveBottomLeftCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomRight;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerBottomRight);
        }
        if (haveBottomRightCorner) {
            _rectCorner = _rectCorner | UIRectCornerBottomLeft;
        }else{
            _rectCorner = _rectCorner & (~UIRectCornerBottomLeft);
        }
    }
    _isChangeCorner = YES;
}

#pragma mark - setter

- (void)setRelyRect:(CGRect)relyRect{
    _relyRect = relyRect;
     [self dealUpdateUI];
}

- (void)setAtPoint:(CGPoint)atPoint{
    _atPoint = atPoint;
    [self dealUpdateUI];
}

- (void)setArrowWidth:(CGFloat)arrowWidth{
    _arrowWidth =arrowWidth;
     [self dealUpdateUI];
}

- (void)setArrowHeight:(CGFloat)arrowHeight{
    _arrowHeight = arrowHeight;
     [self dealUpdateUI];
}

- (void)setArrowPosition:(CGFloat)arrowPosition{
    _arrowPosition = arrowPosition;
     [self dealUpdateUI];
}

- (void)setOffset:(CGFloat)offset{
    _offset = offset;
     [self dealUpdateUI];
}

- (void)setItemHeight:(CGFloat)itemHeight{
    _itemHeight = itemHeight;
     [self dealUpdateUI];
}

- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
     [self dealUpdateUI];
}



- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
     [self dealUpdateUI];
}

- (void)setArrowDirection:(KBPopMenuArrowDirection)arrowDirection{
    _arrowDirection = arrowDirection;
     [self dealUpdateUI];
}

- (void)setPriorityArrowDirection:(KBPopMenuPriorityArrowDirection)priorityArrowDirection{
    _priorityArrowDirection = priorityArrowDirection;
     [self dealUpdateUI];
}

- (void)setRectCorner:(UIRectCorner)rectCorner{
    _rectCorner = rectCorner;
     [self dealUpdateUI];
}


- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    [self addSubview:contentView];
    [self dealUpdateUI];
}

- (void)setContentVC:(UIViewController *)contentVC{
    _contentVC = contentVC;
    self.contentView = contentVC.view;
    [self dealUpdateUI];
}


@end
