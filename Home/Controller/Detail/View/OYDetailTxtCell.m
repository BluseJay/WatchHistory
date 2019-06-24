//
//  OYDetailTxtCell.m
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYDetailTxtCell.h"

@implementation OYDetailTxtCell
{
    UILabel *_content;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    UILabel *content = [[UILabel alloc]init];
    content.numberOfLines = 0;
    content.font = [UIFont boldSystemFontOfSize:WIDTH_RATIO(14)];
    content.textColor = Hex(0x222222);
    [self.contentView addSubview:content];
    _content = content;
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(WIDTH_RATIO(10), WIDTH_RATIO(10), WIDTH_RATIO(10), WIDTH_RATIO(10)));
    }];
}
-(void)setupDataWithTxt:(NSString *)txt font:(nonnull UIFont *)font{
    _content.text = txt;
    _content.font = font;
}
@end
