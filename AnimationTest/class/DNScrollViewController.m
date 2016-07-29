//
//  DNScrollViewController.m
//  AnimationTest
//
//  Created by DaisyNew on 16/7/28.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "DNScrollViewController.h"
#import "DNScrollView.h"

@interface DNScrollViewController ()<DNScrollViewDelegate>{
    
    NSInteger _num;     //显示第几条内容
}

/**
   跑马灯视图
 */
@property (nonatomic, strong) DNScrollView  *dView;

/**
   内容数组
 */
@property (nonatomic, strong) NSArray          *textArr;

@end

@implementation DNScrollViewController

- (void)dealloc{
    
    _dView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    [self datasource];
    [self scrollView];
}

- (void)datasource{
    
    self.textArr = @[@"春眠不觉晓，处处闻啼鸟，夜来风雨声，花落知多少。",
                             @"鹅，鹅，鹅，曲项向天歌，白毛浮绿水，红掌拨清波。",
                             @"床前明月光，疑是地上霜，举头望明月，低头思故乡。",
                             @"离离原上草，一岁一枯荣，野火烧不尽，春风吹又生。"];
}

- (void)scrollView{
    
    _num = 0;
    
    //配置跑马灯视图：方向、速度、位置、字体颜色，并开始动画
    _dView = [[DNScrollView  alloc]initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width-100, 50)];
    _dView.direction = DNScrollToLeft;
    _dView.speed = 1.f;
    _dView.textCol = [self randomColor];
    _dView.delegate = self;
    [self.view addSubview:_dView];
    
    _dView.textString = _textArr[_num];
    [_dView reloadData];
    [_dView startAnimation];
}

#pragma mark - DNScrollView Delegate
- (void)DNScrollView:(DNScrollView *)scrollView animationDidFinished:(BOOL)flag{
    
    [_dView stopAnimation];
    
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        if (_num < _textArr.count -1 ) {
            _num ++;
        }else{
            _num = 0;
        }
        _dView.textString = _textArr[_num];
        [_dView reloadData];
        [_dView startAnimation];
    });
}

#pragma mark -actions
- (UIColor *)randomColor{
    
    return [UIColor colorWithRed: [self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}


- (CGFloat)randomValue{
    
    return arc4random() % 256/255.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
