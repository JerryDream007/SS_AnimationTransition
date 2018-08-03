//
//  CommonMagicMoveCollectionViewCell.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CommonMagicMoveCollectionViewCellID;

@interface CommonMagicMoveCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic,copy) NSString * currentImageName;

@end
