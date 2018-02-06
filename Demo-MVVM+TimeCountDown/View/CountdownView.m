//
//  CountdownView.m
//  Demo-MVVM+TimeCountDown
//
//  Created by haoyajuan on 16/6/20.
//  Copyright © 2016年 haoyajuan. All rights reserved.
//

#import "CountdownView.h"
#import "OrderTableViewCell.h"
#import "OrderTableViewCellFrames.h"


//动态获取设备高度和宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kCloseViewHeight 50.0f
#define kHeaderViewHeight 80.0f

@interface CountdownView ()<UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate>
{
    UITableView *countDownListTableView;
    UIView *closeView;
}

@property (nonatomic,strong) UIView *tableHeaderView;
@property (nonatomic,strong) NSArray *framesArray;
@end

@implementation CountdownView

/*接受数据源 并且刷新数据*/
- (void)setFramesArray:(NSArray *)framesArray{
    _framesArray = framesArray;
    [countDownListTableView reloadData];
}

/*接受数据源 并且刷新数据*/
- (void)reloadDatasWith:(NSArray *)array{
    self.framesArray = array;
}

#pragma mark - MakeUIViews
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        /*不影响子控件的透明度*/
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8f]];
        /*创建页面*/
        [self makeTableViewWithFrame:CGRectMake(0, 20,IPHONE_WIDTH, IPHONE_HEIGHT-20)];
    }
    return self;
}

- (void)makeTableViewWithFrame:(CGRect)frame{
    closeView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-kCloseViewHeight, frame.size.width, kCloseViewHeight)];
    closeView.backgroundColor = [UIColor clearColor];
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, kCloseViewHeight-5, kCloseViewHeight-5)];
    [closeBtn setImage:[UIImage imageNamed:@"clearButton"] forState:UIControlStateNormal];
    closeBtn.center = CGPointMake(closeView.center.x, closeBtn.frame.size.height/2);
    [closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [closeView addSubview:closeBtn];
    [self addSubview:closeView];
    
    countDownListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-kCloseViewHeight)];
    countDownListTableView.backgroundColor = [UIColor clearColor];
    countDownListTableView.dataSource = self;
    countDownListTableView.delegate = self;
    countDownListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    countDownListTableView.tableHeaderView = self.tableHeaderView;
    [self addSubview:countDownListTableView];
}
/*关闭页面时,block出去,杀掉线程*/
- (void)clickCloseBtn{
    [self removeFromSuperview];
    if (_killThreadBlock) {
        _killThreadBlock();
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 0;
    return self.framesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"countDownCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    OrderTableViewCellFrames *frame = self.framesArray[indexPath.row];
    cell.seatFrame = frame;
    
    return cell;
}
/*动态调整cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCellFrames *frame = self.framesArray[indexPath.row];
    return frame.fCellHeight;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, kHeaderViewHeight)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, kHeaderViewHeight)];
        titleLabel.text = @"倒计时页面";
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [_tableHeaderView addSubview:titleLabel];
    }
    return _tableHeaderView;
}

#pragma mark - 按钮的点击事件传递出去
- (void)clickButtonWithOrderInfoModel:(OrderInfoModel *)oderModel{
    [self.delegate clickButtonWithOrderInfoModel:oderModel];
}

@end
