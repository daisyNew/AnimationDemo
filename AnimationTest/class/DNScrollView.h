//
//  DNScrollView.h
//  AnimationTest
//
//  Created by DaisyNew on 16/7/28.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   跑马灯方向
 */
typedef NS_ENUM(NSInteger, DNScrollerDirection){
    
    DNScrollToLeft,     //向左滚动
    DNScrollToRight,     //向右滚动
    DNScrollToTop,     //向上
    DNScrollToBottom,  //向下
};



@class DNScrollView;

@protocol DNScrollViewDelegate <NSObject>

- (void)DNScrollView:(DNScrollView *)scrollView animationDidFinished:(BOOL)flag;

@end




//方向、颜色、速度
@interface DNScrollView : UIView

@property (nonatomic, assign) DNScrollerDirection direction;
@property (nonatomic, assign) CGFloat                    speed;
@property (nonatomic, strong) NSString                   *textString;
@property (nonatomic, strong) UIColor                     *textCol;
@property (nonatomic, assign)  id <DNScrollViewDelegate> delegate;


- (void)reloadData;
- (void)startAnimation;
- (void)stopAnimation;

@end
