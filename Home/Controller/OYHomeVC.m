//
//  OYHomeVC.m
//  WatchHistory
//
//  Created by oy on 2019/5/28.
//  Copyright © 2019 oy. All rights reserved.
//

#import "OYHomeVC.h"
#import "OYHomeCell.h"
#import "OYHomeModel.h"
#import "OYDetailVC.h"


@interface OYHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_listView;
    NSArray *_listArr;
    NSDate *_pickDate;
    UILabel *_dateLab;
    
    UIView *_shadowView;
    UIView *_pickerView;
}
@end

@implementation OYHomeVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestHistoryDataWithDate:nil];
}

#pragma mark - setupUI
-(void)setupUI {
    
    UIView *navView = [self setupNavView];
    [self.contentView addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.mas_equalTo(WIDTH_RATIO(44));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *listView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    listView.backgroundColor = Hex(0x6E929A);
    listView.delegate = self;
    listView.dataSource = self;
    [self.contentView addSubview:listView];
    _listView = listView;
    
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];
    
    [listView registerClass:[OYHomeCell class] forCellWithReuseIdentifier:@"OYHomeCell"];
}

-(UIView *)setupNavView {
    UIView *bgView = [[UIView alloc]init];
    
    //日期
    UILabel *dateLab = [[UILabel alloc]init];
    dateLab.textColor = Hex(0x999999);
    dateLab.font = [UIFont systemFontOfSize:WIDTH_RATIO(12)];
    [bgView addSubview:dateLab];
    _dateLab = dateLab;
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(WIDTH_RATIO(14));
        make.centerY.offset(0);
    }];
    
    //标题
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"Watch History";
    titleLab.textColor = Hex(0x222222);
    titleLab.font = [UIFont systemFontOfSize:WIDTH_RATIO(17)];
    [bgView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    //日历
    UIButton *calendarBtn = [[UIButton alloc]init];
    [calendarBtn setImage:IMG(@"home_date") forState:UIControlStateNormal];
    [calendarBtn addTarget:self action:@selector(showCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:calendarBtn];
    
    [calendarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(WIDTH_RATIO(-15));
        make.centerY.offset(0);
        make.width.height.mas_equalTo(WIDTH_RATIO(19));
    }];
    
    return bgView;
}

-(void)setupDateView {
    
    UIView *shadowView = [[UIView alloc]init];
    shadowView.backgroundColor = AHex(0x000000, 0.6);
    [self.contentView addSubview:shadowView];
    _shadowView = shadowView;
    
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = Hex(0xffffff);
    [self.contentView addSubview:bgView];
    _pickerView = bgView;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(WIDTH_RATIO(300));
    }];
    
    UIView *toolView = [self setupToolView];
    [bgView addSubview:toolView];
    
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(WIDTH_RATIO(50));
    }];
    
    UIView *pickerView = [self setupPickerView];
    [bgView addSubview:pickerView];
    
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
   
}
-(UIView *)setupToolView {
    UIView *bgView = [[UIView alloc]init];
    
    //cancel
    UIButton *cancelBtn = [self setupBtnWithTitle:@"Cancel" color:Hex(0x83241A) tag:0];
    [bgView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(WIDTH_RATIO(10));
        make.top.bottom.offset(0);
        make.width.mas_equalTo(WIDTH_RATIO(80));
    }];
    
    //comfirm
    UIButton *confirmBtn = [self setupBtnWithTitle:@"Confirm" color:Hex(0x9FCCEF) tag:1];
    [bgView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(WIDTH_RATIO(-10));
        make.top.bottom.offset(0);
        make.width.mas_equalTo(WIDTH_RATIO(80));
    }];
    
    return bgView;
}
-(UIButton *)setupBtnWithTitle:(NSString *)title color:(UIColor *)color tag:(NSInteger)tag {
    UIButton *tempBtn = [[UIButton alloc]init];
    tempBtn.tag = 10000+tag;
    [tempBtn setTitle:title forState:UIControlStateNormal];
    [tempBtn setTitleColor:color forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(toolFounction:) forControlEvents:UIControlEventTouchUpInside];
    return tempBtn;
}
-(UIView *)setupPickerView {
    UIView *bgView = [[UIView alloc]init];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date] animated:YES];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [bgView addSubview:datePicker];
    
    
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    return bgView;
}
#pragma mark - picker method

#pragma mark - collectionview Method
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OYHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OYHomeCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.clipsToBounds = YES;
    return cell;
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OYHomeCell *hCell = (OYHomeCell *)cell;
    OYHomeDataDetailModel *model = _listArr[indexPath.row];
    [hCell setupDataWithImg:model.src title:model.title];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tempNum = 0;
    float tempHeight = 0;
    float tempMargin = 0;
    float tempSideMargin = 0;
    float tempSpace = 4;//误差值
    if (indexPath.section == 0) {
        tempNum = 2;
        tempHeight = 243.0;
        tempSideMargin =  15;
        tempMargin =  5;
    }
    
    float wh = (SCREEN_WIDTH - (tempNum-1) * WIDTH_RATIO(tempMargin) - WIDTH_RATIO(tempSideMargin) * 2)/tempNum;
    
    return CGSizeMake(wh-tempSpace,WIDTH_RATIO(tempHeight));
}
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(WIDTH_RATIO(15), WIDTH_RATIO(15), WIDTH_RATIO(15), WIDTH_RATIO(15));
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    OYDetailVC *detail = [OYDetailVC new];
    OYHomeDataDetailModel *model = _listArr[indexPath.row];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - EVENT
-(void)showCalendar:(UIButton *)sender {
    _pickDate = [NSDate date];
    [self setupDateView];
}
-(void)toolFounction:(UIButton *)sender {
    NSInteger tempIndex = sender.tag - 10000;
    if (tempIndex == 1) {
        [self requestHistoryDataWithDate:_pickDate];
    }
    [self hidePickView];
}
-(void)dateChange:(UIDatePicker *)datePicker {
    
    _pickDate = datePicker.date;
}
-(void)hidePickView {
    [_shadowView removeFromSuperview];
    [_pickerView removeFromSuperview];
    _shadowView = nil;
    _pickerView = nil;
}
#pragma mark - request
-(void)requestHistoryDataWithDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|kCFCalendarUnitMonth fromDate:date?date:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM.dd";
    self->_dateLab.text = [formatter stringFromDate:date?date:[NSDate date]];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:[NSString stringWithFormat:@"%ld",[components month]] forKey:@"month"];
    [para setObject:[NSString stringWithFormat:@"%ld",[components day]] forKey:@"day"];
    [para setObject:@"en" forKey:@"type"];
    
    [[OYHttpRequest sharedInstance] getWithURLString:BaseUrl parameters:para success:^(id  _Nonnull responseObject) {
        OYHomeModel *dataModel = [OYHomeModel yy_modelWithDictionary:responseObject];
        self->_listArr = dataModel.data.data;
        [self->_listView reloadData];
        if (self->_listArr.count==0) {
            Toast_Center(@"Didn't search any history events of this day !!")
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
    } ifShowLoading:YES];
}
@end

