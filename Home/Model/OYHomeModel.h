//
//  OYHomeModel.h
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface OYHomeDataDetailModel : NSObject
@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *src;
@property(nonatomic, copy)NSString *content;

@end
@interface OYHomeDataModel : NSObject
@property(nonatomic, copy)NSString *total;
@property(nonatomic, copy)NSString *per_page;
@property(nonatomic, copy)NSString *current_page;
@property(nonatomic, copy)NSString *last_page;
@property(nonatomic, copy)NSArray<OYHomeDataDetailModel *> *data;
@end
@interface OYHomeModel : OYBaseModel
@property(nonatomic, strong)OYHomeDataModel *data;
@end

NS_ASSUME_NONNULL_END
