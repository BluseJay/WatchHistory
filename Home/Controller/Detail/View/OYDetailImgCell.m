//
//  OYDetailImgCell.m
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYDetailImgCell.h"

@implementation OYDetailImgCell
{
    UIImageView *_contentImg;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    UIImageView *contentImg = [[UIImageView alloc]initWithImage:IMG(@"")];
//    contentImg.backgroundColor = randomColor;
    contentImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:contentImg];
    _contentImg = contentImg;
    
    
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(WIDTH_RATIO(10), WIDTH_RATIO(10), WIDTH_RATIO(10), WIDTH_RATIO(10)));
        make.width.mas_equalTo(WIDTH_RATIO(345));
        make.height.mas_equalTo(WIDTH_RATIO(240));
    }];
    
    
}
-(void)setupDataWitImg:(NSString *)img {
    [_contentImg sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:IMG(@"loading")];
}
@end
