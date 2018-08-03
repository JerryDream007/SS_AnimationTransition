//
//  CommonMaskDetailViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/19.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonMaskDetailViewController.h"

@interface CommonMaskDetailViewController ()

@end

@implementation CommonMaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"maskDetailVC : \n self = %@ \n self.view = %@",self,self.view);
}

- (void)dealloc{
    NSLog(@"MaksDetailVC销毁了");
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
