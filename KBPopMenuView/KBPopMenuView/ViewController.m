//
//  ViewController.m
//  KBPopMenuView
//
//  Created by kobe on 2017/7/31.
//  Copyright © 2017年 kobe. All rights reserved.
//

#import "ViewController.h"
#import "KBPopMenuView.h"
#import "TestVC.h"
#import "TestView.h"

@interface ViewController ()
{
    KBPopMenuView *menu;
    UIView *view;
    UIButton *btn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(100, 280, 100, 100);
    [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    
    
}


- (void)touchBtn:(UIButton *)btn{
//       menu = [KBPopMenuView showMenuAtPoint:CGPointMake(100, 300)];
//        menu = [KBPopMenuView showMenuRelyOnView:btn];
//    menu.arrowDirection = KBPopMenuArrowDirectionLeft;
    menu.priorityArrowDirection = KBPopMenuPriorityArrowDirectionRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.view];
    TestView *view1 = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 200, 220)];
//    view1.backgroundColor = [UIColor redColor];
    menu = [KBPopMenuView showMenuAtPoint:p viewSize:CGSizeMake(200, 220)];
    
    
//    TestVC *one = [TestVC new];
//    one.view.backgroundColor = [UIColor orangeColor];
    
    menu.contentView = view1;
//    menu.contentVC = one;
   
    
    
   
    
}

@end















