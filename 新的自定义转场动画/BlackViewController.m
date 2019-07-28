//
//  BlackViewController.m
//  新的自定义转场动画
//
//  Created by wyx on 2019/7/28.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "BlackViewController.h"
#import "CircleTranslation.h"
@interface BlackViewController ()<UINavigationControllerDelegate>

@end

@implementation BlackViewController
- (IBAction)click:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [CircleTranslation new];
    }else{
        return nil;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
