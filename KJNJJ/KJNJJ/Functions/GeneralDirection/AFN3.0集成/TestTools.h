//
//  TestTools.h
//  KJNJJ
//
//  Created by coco船长 on 2016/10/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  为满足6月份苹果公司添加的新规定：IPV6-ONLY.
 *  我用的是AFNetworking框（具体的一些细节以及注意点网上看到一篇文章，介绍的比较详细：（详情：http://blog.csdn.net/gavin__fan/article/details/51498322））
 *  为了满足这一规定，特将AFNetworking升级到（3.0）。有一定程度的改（详情：http://www.jianshu.com/p/047463a7ce9b）
 *  这里，引用AFNetworking和json框架，封装简化了一些网络请求的过程。
 */

@interface TestTools : NSObject

//GET--AFN+JSON
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure;

//POST--AFN+JSON
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure;

//GET--NETWORK
+ (BOOL)getNetwork;

//POST-UPDATE--FILE(MimeType)
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
        data:(NSMutableDictionary *)datas
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure;

@end
