//
//  ViewController.m
//  NavigationAlpha
//
//  Created by Hosel on 2017/8/19.
//  Copyright © 2017年 Hosel. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+ZM.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置导航渐变颜色";
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setTable];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //设置导航
    [self setNavigation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    //将导航条置为原色
    [self.navigationController.navigationBar reset];
}

#pragma mark - 设置导航
- (void)setNavigation{
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setBackgroundColor:[[UIColor purpleColor] colorWithAlphaComponent:0]];
    
//    [self hideBarBottomLine];
    
    //    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];
}

- (void)hideBarBottomLine
{
    // 不用填充的方式，改用隐藏分隔线所属的控件，便于恢复
    //    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (UIImage *)imageWithBgColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationController.navigationBar setBackgroundColor:[[UIColor purpleColor] colorWithAlphaComponent:self.table.contentOffset.y / 100]];
}

//设置table
- (void)setTable{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor cyanColor];
    self.table = table;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
