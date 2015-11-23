//
//  ViewController.m
//  GXKRefreshDemo
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "GXKRefresh.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GXKRefreshDelegate>


@property (nonatomic ,strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    //footerTemp-------------------------------------------------------------------
    
//    GPFooterView * footerView = [GPFooterView footerView];
//    [self.tableView addSubview:footerView];
    //footerView.delegate = self;
    [self.tableView addGXKRefreshFooter];
    //Set delegate like this(temp).
    self.tableView.refreshFooterView.delegate = self;
    
    //HeaderTemp-------------------------------------------------------------------
    
    [self.tableView addGXKRefreshHeader];
    self.tableView.refreshHeaderView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)refreshFooter:(GXKRefreshFooterView *)footerView state:(GXKRefreshState)state
{
    NSLog(@"----%@,--",footerView);
    //
    [self performSelector:@selector(dealFooterState) withObject:nil afterDelay:5];
}
- (void)refreshHeader:(GXKRefreshHeaderView *)headerView state:(GXKRefreshState)state
{
    NSLog(@"******%@***",headerView);
    [self performSelector:@selector(dealHeaderState) withObject:nil afterDelay:5];
}
- (void)dealFooterState
{
    [self.tableView endRefreshingGXKRefreshFooter];
}
- (void)dealHeaderState
{
    [self.tableView endRefreshingGXKRefreshHeader];
}
@end
