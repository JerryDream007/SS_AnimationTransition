//
//  CommonTikTokDetailCollectionViewCell.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/17.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonTikTokDetailCollectionViewCell.h"

NSString * const CommonTikTokDetailCollectionViewCellID = @"CommonTikTokDetailCollectionViewCellID";

@interface CommonTikTokDetailCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCommentLabel;

@end

@implementation CommonTikTokDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCurrentImageName:(NSString *)currentImageName{
    _currentImageName = currentImageName;
    self.userImageView.image = [UIImage imageNamed:currentImageName];
    self.userNickNameLabel.text = [NSString stringWithFormat:@"昵称%@",currentImageName];
    self.userCommentLabel.text = [NSString stringWithFormat:@"评论%@",currentImageName];
}


@end
