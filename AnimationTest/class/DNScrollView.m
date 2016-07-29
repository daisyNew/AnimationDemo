//
//  DNScrollView.m
//  AnimationTest
//
//  Created by DaisyNew on 16/7/28.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "DNScrollView.h"

@interface DNScrollView(){
    CGFloat  _width;
    CGFloat  _animationLabWidth;
    CGFloat  _animationLabHeight;

    BOOL        _stoped;
    NSInteger  _textNum;
}

@property (nonatomic, strong) UILabel *animationLab;
@property (nonatomic, assign) CGPoint fromPoint;
@property (nonatomic, assign) CGPoint toPoint;
@property (nonatomic, assign) CGFloat scrollDuration;

@end

@implementation DNScrollView



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _width = frame.size.width;
        self.layer.masksToBounds = YES;
       
        self.animationLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:_animationLab];

    }
    return self;
    
}

- (void)reloadData{
        
    NSString *string = [NSString stringWithFormat:@"%@",_textString];
    
    CGFloat width = [self widthWithString:string];
    
    _animationLab.frame = CGRectMake(0, 0, width, 20) ;
    _animationLab.text = string;
    _animationLab.font = [UIFont systemFontOfSize:14];
    _animationLab.textColor = _textCol;
    
    _animationLabWidth = width ;
    _animationLabHeight = 20;
}

- (CGFloat)widthWithString:(NSString *)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                     options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}
                                     context:nil];
    
    return  rect.size.width;
}

- (CGPoint)fromPoint{
    
    switch (self.direction) {
        case DNScrollToTop:
        {
            return CGPointMake(self.frame.size.width /2, self.frame.size.height );
        }
        case DNScrollToBottom:
        {
            return CGPointMake(self.frame.size.width /2, -_animationLabHeight);
        }
        case DNScrollToLeft:
        {
            return CGPointMake(_width + _animationLabWidth/2, self.frame.size.height /2.f);
        }
        case DNScrollToRight:
        {
            return CGPointMake(-_animationLabWidth/2, self.frame.size.height /2.f);
        }
        default:
            break;
    }
}

- (CGPoint)toPoint{
    
    switch (self.direction) {
        case DNScrollToTop:
        {
            return CGPointMake(self.frame.size.width /2,-_animationLabHeight);
        }
        case DNScrollToBottom:
        {
            return CGPointMake(self.frame.size.width /2, self.frame.size.height + _animationLabHeight);
        }
        case DNScrollToLeft:
        {
            return CGPointMake(-_animationLabWidth/2, self.frame.size.height /2.f);
        }
        case DNScrollToRight:
        {
            return CGPointMake(_width + _animationLabWidth/2, self.frame.size.height /2.f);
        }
        default:
            break;
    }
}

- (CGFloat)scrollDuration{
    
    switch (self.direction) {
        case DNScrollToTop:
        {
            return  _animationLabHeight / 5.0f * (1 / self.speed);
        }
        case DNScrollToBottom:
        {
            return  _animationLabHeight / 5.0f * (1 / self.speed);
        }
        case DNScrollToLeft:
        {
            return _animationLabWidth / 30.0f * (1 / self.speed);
        }
        case DNScrollToRight:
        {
            return _animationLabWidth / 30.0f * (1 / self.speed);
        }
        default:
            break;
    }

}
- (void)startAnimation{
    
    [self.animationLab.layer removeAnimationForKey:@"animationViewPosition"];

    _stoped = NO;
    
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:self.fromPoint];
    [movePath addLineToPoint:self.toPoint];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = movePath.CGPath;
    moveAnimation.removedOnCompletion = YES;

    moveAnimation.duration = self.scrollDuration;
    moveAnimation.delegate =  self;
    [self.animationLab.layer addAnimation:moveAnimation forKey:@"animationViewPosition"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(DNScrollView:animationDidFinished:)]) {
        
        [self.delegate DNScrollView:self animationDidFinished:flag];
    }
    
    if (flag && !_stoped) {
        
        [self startAnimation];
    }
}

- (void)stopAnimation {
    
    self.animationLab.text = @"";
    _stoped = YES;
    [self.animationLab.layer removeAnimationForKey:@"animationViewPosition"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
