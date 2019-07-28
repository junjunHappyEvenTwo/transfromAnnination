//
//  ViewController.m
//  新的自定义转场动画
//
//  Created by wyx on 2019/7/28.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "ViewController.h"
#import "CircleTranslation.h"
@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        CircleTranslation *c = [CircleTranslation new];
        c.isPush = YES;
        return c;
    }else{
        return  nil;
    }
}


@end
