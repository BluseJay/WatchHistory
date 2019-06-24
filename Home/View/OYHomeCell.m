//
//  OYHomeCell.m
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYHomeCell.h"

@implementation OYHomeCell
{
    UIImageView *_bgImg;
    UILabel *_title;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    self.contentView.backgroundColor = Hex(0xffffff);
    
    UIImageView *bgImg = [[UIImageView alloc]initWithImage:IMG(@"")];
//    bgImg.backgroundColor = randomColor;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.clipsToBounds = YES;
    [self.contentView addSubview:bgImg];
    _bgImg = bgImg;
    
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, WIDTH_RATIO(73), 0));
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.numberOfLines = 0;
    title.textColor = Hex(0x222222);
    title.font = [UIFont boldSystemFontOfSize:WIDTH_RATIO(16)];
    [self.contentView addSubview:title];
    _title = title;
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom).offset(WIDTH_RATIO(10));
        make.left.offset(WIDTH_RATIO(10));
        make.right.bottom.offset(WIDTH_RATIO(-10));
        
    }];
    
}

-(void)setupDataWithImg:(NSString *)img title:(NSString *)title {
    [_bgImg sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:IMG(@"loading")];
    _title.text = title;
}
@end
