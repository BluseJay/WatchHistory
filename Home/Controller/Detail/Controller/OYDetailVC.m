//
//  OYDetailVC.m
//  WatchHistory
//
//  Created by oy on 2019/6/20.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYDetailVC.h"
#import "OYDetailImgCell.h"
#import "OYDetailTxtCell.h"

@interface OYDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OYDetailVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail";
    [self setupUI];
}
#pragma mark - 设置UI
-(void)setupUI {
    
    UITableView *detailTab = [[UITableView alloc]init];
    detailTab.delegate = self;
    detailTab.dataSource = self;
    detailTab.bounces = NO;
    detailTab.estimatedRowHeight = 100;
    detailTab.rowHeight = UITableViewAutomaticDimension;
    detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:detailTab];
    
    [detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}
#pragma mark - tableview方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        OYDetailImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OYDetailImgCell"];
        if (!cell) {
            cell = [[OYDetailImgCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"OYDetailImgCell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        [cell setupDataWitImg:self.model.src];
        return cell;
    }
    
    OYDetailTxtCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OYDetailTxtCell"];
    if (!cell) {
        cell = [[OYDetailTxtCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"OYDetailTxtCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    if (indexPath.row == 0) {
        [cell setupDataWithTxt:self.model.title font:[UIFont boldSystemFontOfSize:WIDTH_RATIO(16)]];
    }else{
        [cell setupDataWithTxt:self.model.content font:[UIFont systemFontOfSize:WIDTH_RATIO(14)]];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
