//
//  ViewController.h
//  KJNJJ
//
//  Created by coco船长 on 2016/10/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    //功能列表
    UITableView     *_functionTable ;
    
    //功能数组
    NSArray         *_functionArr;
    
    //是否下拉
    NSMutableArray  *_isOpen;
    
}


@end

