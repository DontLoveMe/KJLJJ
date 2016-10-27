//
//  ViewController.m
//  KJNJJ
//
//  Created by coco船长 on 2016/10/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 *在这里将功能分为:1.小功能,2.大方向（ps:功能的增加会在下方列举出来）
 *1.小功能:a.手电筒 , 
 *2.大方向:a.AFN-3.0公共方法集成。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置视图基本属性
    self.title = @"空几里记几";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //下拉收起状态初始化
    _isOpen = [NSMutableArray arrayWithArray:@[@"0",@"0"]];
    
    //初始化功能数组
    _functionArr = @[@{@"title":@"小功能",
                       @"functionList":@[@"手电筒"]},
                     @{@"title":@"大方向",
                       @"functionList":@[@"AFN-3.0",@"轨迹回放"]}];
    
    //功能Table，在这里采用下拉的形式，展示起分组功能
    _functionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _functionTable.backgroundColor = [UIColor clearColor];
    _functionTable.delegate = self;
    _functionTable.dataSource = self;
    [self.view addSubview:_functionTable];
    
}

#pragma mark - UITableViewDelagate,UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _functionArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //根据功能列表分组
    NSDictionary *sectionValue = [_functionArr objectAtIndex:section];
    NSArray *functionList = [sectionValue objectForKey:@"functionList"];
    //收起状态
    NSInteger isopen = [[_isOpen objectAtIndex:section] integerValue];
    if (isopen == 0) {
        
        return  0;
    
    }else{
    
        return functionList.count;
    
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSDictionary *sectionValue = [_functionArr objectAtIndex:section];
    return  [sectionValue objectForKey:@"title"];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //自定义头视图
    UIButton *headButton = [[UIButton alloc] init];
    headButton.tag = 100 + section;
    [headButton addTarget:self
                   action:@selector(openOrCloseAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    //向左向下图标
    UIButton *markImg = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 28.f, 15.f, 14.f, 14.f)];
    markImg.userInteractionEnabled = NO;
    markImg.tag = 200 + section;
    [markImg setBackgroundImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [markImg setBackgroundImage:[UIImage imageNamed:@"向下"] forState:UIControlStateSelected];
    //收起状态
    NSInteger isopen = [[_isOpen objectAtIndex:section] integerValue];
    if (isopen == 0) {
        
        markImg.selected = NO;
        
    }else{
        
        markImg.selected = YES;
        
    }
    [headButton addSubview:markImg];
    
    //标题
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, self.view.bounds.size.width - 28, 44.f)];
    NSDictionary *sectionValue = [_functionArr objectAtIndex:section];
    textLabel.text = [sectionValue objectForKey:@"title"];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textAlignment = NSTextAlignmentLeft;
    [headButton addSubview:textLabel];
    
    return headButton;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44.f;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //创建cell，并设置cell属性
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //获取数据
    NSDictionary *sectionValue = [_functionArr objectAtIndex:indexPath.section];
    NSArray *functionList = [sectionValue objectForKey:@"functionList"];
    cell.textLabel.text = [functionList objectAtIndex:indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //在这里跳转到某一个具体功能
    //小功能还是大方向
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            //手电筒
            FlashLightController *FLVC = [[FlashLightController alloc] init];
            FLVC.title = @"手电筒";
            [self.navigationController pushViewController:FLVC
                                                 animated:YES];
        }
        
    }else{
        
        if (indexPath.row == 0) {
            //网络请求公共类
            NetWorkController *NWVC = [[NetWorkController alloc] init];
            NWVC.title = @"AFN-3.0";
            [self.navigationController pushViewController:NWVC
                                                 animated:YES];
        }else if(indexPath.row == 1){
            //轨迹
            
        
        }
    
    }
    
}

//下拉或者收起事件
- (void)openOrCloseAction:(UIButton *)button{

    //修改保存是否下拉状态的数组
    NSInteger isopen = [[_isOpen objectAtIndex:button.tag - 100] integerValue];
    isopen = 1 - isopen;
    [_isOpen replaceObjectAtIndex:button.tag - 100 withObject:[NSNumber numberWithInteger:isopen]];
    //刷新某一组
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:button.tag - 100];
    [_functionTable reloadSections:indexset
                  withRowAnimation:UITableViewRowAnimationAutomatic];

}


@end
