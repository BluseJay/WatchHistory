//
//  OYHomeModel.m
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYHomeModel.h"

@implementation OYHomeModel

@end
@implementation OYHomeDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"data":[OYHomeDataDetailModel class]};
}

@end
@implementation OYHomeDataDetailModel


@end
