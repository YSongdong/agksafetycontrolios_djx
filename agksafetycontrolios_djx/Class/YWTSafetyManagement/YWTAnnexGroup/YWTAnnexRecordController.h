//
//  AnnexRecordController.h
//  PartyBuildingStar
//
//  Created by tiao on 2019/3/22.
//  Copyright © 2019年 wutiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseController.h"

@protocol AnnexRecordControllerDelegate <NSObject>

-(void) selectAudioListDict:(NSDictionary *)dcit;

@end

@interface YWTAnnexRecordController : SDBaseController

@property (nonatomic,weak) id<AnnexRecordControllerDelegate> delegate;

@end


