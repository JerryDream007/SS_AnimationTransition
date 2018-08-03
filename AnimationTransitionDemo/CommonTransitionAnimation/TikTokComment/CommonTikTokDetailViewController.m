//
//  CommonTikTokDetailViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/16.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonTikTokDetailViewController.h"
#import "SS_AnimationTransition.h"
#import "CommonTikTokDetailCollectionViewCell.h"

@interface CommonTikTokDetailViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) UIPanGestureRecognizer * panGesture;

@end

@implementation CommonTikTokDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"抖音评论详情";
    self.view.backgroundColor = [UIColor clearColor];
    self.view.layer.cornerRadius = 13;
    self.view.clipsToBounds = YES;

    self.dataSource = [NSMutableArray array];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGFloat itemWith = self.view.frame.size.width;
    flowLayout.itemSize = CGSizeMake(itemWith, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*2/3) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CommonTikTokDetailCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:CommonTikTokDetailCollectionViewCellID];
    
    for(int i = 1; i < 12; i++){
        NSString * tempString = [NSString stringWithFormat:@"%d-1",i];
        [self.dataSource addObject:tempString];
    }
    
    [self.collectionView reloadData];
    [self.collectionView.panGestureRecognizer addTarget:self.animationTransitionDelegate action:@selector(handlePanGesture:)];
    
    //防止PanGestureRecognizer.state更新不及时,导致程序卡死 (stateh会一直在UIGestureRecognizerStateChanged,导致转场一直update)
    [self addObserver:self forKeyPath:@"collectionView.panGestureRecognizer.state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    id newValue = change[NSKeyValueChangeNewKey];
    if ([newValue integerValue] == 3) {
        [self.animationTransitionDelegate finishInteractiveTransition];
    }
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= 0) {
        self.animationTransitionDelegate.isOpenPanGesture = YES;
    }else{
        self.animationTransitionDelegate.isOpenPanGesture = NO;
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
    CommonTikTokDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CommonTikTokDetailCollectionViewCellID forIndexPath:indexPath];
    cell.currentImageName = self.dataSource[indexPath.item];
    return  cell;
}

@end
