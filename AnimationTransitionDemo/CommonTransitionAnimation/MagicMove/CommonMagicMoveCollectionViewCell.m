//
//  CommonMagicMoveCollectionViewCell.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonMagicMoveCollectionViewCell.h"

NSString * const CommonMagicMoveCollectionViewCellID = @"CommonMagicMoveCollectionViewCellID";

@interface CommonMagicMoveCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end

@implementation CommonMagicMoveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCurrentImageName:(NSString *)currentImageName{
    _currentImageName = currentImageName;
    self.bgImageView.image = [UIImage imageNamed:currentImageName];
    self.currentLabel.text = currentImageName;
}

@end
