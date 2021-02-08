//
//  YWTParyMemberAreaAddPhotoCell.h
//  agksafetycontrolios_djx
//
//  Created by 世界之窗 on 2019/9/6.
//  Copyright © 2019 世界之窗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWTParyMemberAreaAddPhotoCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *photoImage;
// YES  显示 NO  不显示
@property (nonatomic,assign) BOOL isShowDel;

@property (nonatomic,copy) void(^selectDelImage)(void);

@end

NS_ASSUME_NONNULL_END
