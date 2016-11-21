//
//  ViewController.m
//  ALNavigationBar
//
//  Created by Alan on 2016/11/20.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "ViewController.h"
#import "ALBaseViewController+ALPullHeaderView.h"
#import "UINavigationBar+ALScrolling.h"
#import "UIBarButtonItem+ALAdd.h"
#import "SecViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *contentView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // if changed the navigationBar color need called this method.
//    self.navigationController.navigationBar.al_navigationBarColor = [UIColor redColor];
    // because the next controller also make navigationBar move, so must reset it.
    self.navigationController.navigationBar.al_navigationBarStyle = ALNavigationBarDefault;
    [self scrollViewDidScroll:self.contentView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    
    [self configHeaderView:self.contentView];
    [self configHeaderImage:[UIImage imageNamed:@"bridge"]];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithTitle:@"编辑" block:^(id sender) {
        
    }];
    self.title = @"navigationbar hidden";
    
    //
//    self.navigationController.navigationBar.al_maxOffsetY = 300;
    self.navigationController.navigationBar.al_navigationBarStyle = ALNavigationBarDefault;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%lu个", indexPath.row + 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecViewController *secVc = [[SecViewController alloc] init];
    [self.navigationController pushViewController:secVc animated:YES];
}

- (UITableView *)contentView
{
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
    }
    return _contentView;
}

@end
