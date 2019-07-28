//
//  CircleTranslation.h
//  自定义转场动画
//
//  Created by wyx on 2019/7/28.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CircleTranslation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) BOOL isPush;
@end

NS_ASSUME_NONNULL_END
