//
//  CircleTranslation.m
//  自定义转场动画
//
//  Created by wyx on 2019/7/28.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "CircleTranslation.h"
#import "ViewController.h"
#import "BlackViewController.h"
@interface CircleTranslation()<CAAnimationDelegate>

@property (nonatomic,strong) id <UIViewControllerContextTransitioning>context;
@end

@implementation CircleTranslation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //持有上下文
    _context = transitionContext;
    //2.获取View的容器
    UIView *contrainerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //3.初始化toVC  把toVC的View 添加到容器View
    //添加动画
    ViewController *vc1;
    UIButton *btn;
    BlackViewController *vc2;
    if (_isPush) {
       vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
         btn = vc1.realBtn;
      
    }else{
        vc2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        vc1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc2.redBtn;
      
    }
      [contrainerView addSubview:vc1.view];
      [contrainerView addSubview:vc2.view];
 
    //5  画小圆
  
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint centerP;
    centerP = btn.center;
    //求半径
    CGFloat radius;
    CGFloat y = CGRectGetHeight(toVC.view.frame) - btn.center.y;
    CGFloat x = CGRectGetWidth(toVC.view.frame) - btn.center.x;
    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds)/2) {
        // 1  4
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            //第一象限
            radius = sqrt(btn.center.x * btn.center.x + y * y);
        }else{
            radius = sqrt((btn.center.x * btn.center.x) + (btn.center.y * btn.center.y));
        }
    }else{
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(vc2.view.bounds)/2) {
            //第二
            radius = sqrt(x * x + y * y);
            
        }else{
            radius = sqrt(x * x + btn.center.y * btn.center.y);
        }
        
    }
    //7.。画出大原
      UIBezierPath *bigpath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    //8.
    CAShapeLayer *shap  = [CAShapeLayer layer];
    if (_isPush) {
         shap.path = bigpath.CGPath;
    }else{
        shap.path = smallPath.CGPath;
    }
    UIViewController *vc;
    if (_isPush) {
        vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else{
         vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    //9.添加蒙版
    vc.view.layer.mask = shap;
    //layer添加动画
    CABasicAnimation *anno = [CABasicAnimation animationWithKeyPath:@"path"];
    anno.delegate = self;
    if (_isPush) {
        anno.fromValue = (id)smallPath.CGPath;
    }else{
         anno.fromValue = (id)bigpath.CGPath;
    }
    
    anno.duration = [self transitionDuration:transitionContext];
    [shap addAnimation:anno forKey:nil];
  
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    if (_isPush) {
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        tovc.view.layer.mask = nil;
    }else{
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        tovc.view.layer.mask = nil;
    }
 
}
@end
