//
//  CommonMagicMoveAnimationViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonMagicMoveAnimationViewController.h"
#import "CommonMagicMoveCollectionViewCell.h"
#import "CommonMagicMoveDetailViewController.h"
#import "SS_AnimationTransition.h"

@interface CommonMagicMoveAnimationViewController ()

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) UIView * targetView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CommonMagicMoveAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"神奇移动效果";
    self.dataSource = [NSMutableArray array];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    CGFloat itemWith = (self.view.frame.size.width - 15 * 3)/2;
    flowLayout.itemSize = CGSizeMake(itemWith, itemWith);
    
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CommonMagicMoveCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:CommonMagicMoveCollectionViewCellID];

    for(int i = 1; i < 12; i++){
        NSString * tempString = [NSString stringWithFormat:@"%d-1",i];
        [self.dataSource addObject:tempString];
    }
}

#pragma mark - collectionDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommonMagicMoveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CommonMagicMoveCollectionViewCellID forIndexPath:indexPath];
    cell.currentImageName = self.dataSource[indexPath.item];
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CommonMagicMoveCollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.targetView = cell.bgImageView;
    CommonMagicMoveDetailViewController * detailVC = [[CommonMagicMoveDetailViewController alloc] init];
    detailVC.currentImageName = self.dataSource[indexPath.item];
    [self.navigationController ss_pushViewController:detailVC type:KAnimationTransitionTypeMagicMove];
}

#pragma mark - targetView

- (UIView *)SS_AnimationTransitionTargetView{
    return self.targetView;
}

@end
