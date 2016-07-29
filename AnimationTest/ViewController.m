//
//  ViewController.m
//  AnimationTest
//
//  Created by DaisyNew on 16/7/28.
//  Copyright © 2016年 DaisyNew. All rights reserved.
//

#import "ViewController.h"
#import "DNScrollViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray   *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView.rowHeight = 45;
    self.dataArr = @[@"跑马灯"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        DNScrollViewController *dvc = [[DNScrollViewController alloc]init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
