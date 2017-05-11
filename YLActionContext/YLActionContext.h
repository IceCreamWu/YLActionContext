//
//  YLActionContext.h
//  YLActionContextDemo
//
//  Created by IceCreamWu on 2017/5/10.
//  Copyright © 2017年 IceCreamWu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^YLActionContextCallback)(id data);

/*
 * YLActionContext暂时只支持一对一的行为，如果注册同一个action则会覆盖掉上个注册
 * （需要一对多应该使用NSNotification或者另行支持）
 */
@interface YLActionContext : NSObject

+ (instancetype)actionContext;

- (void)registerAction:(NSString *)action callback:(YLActionContextCallback)callback keyObject:(id)keyObject;
- (void)registerAction:(NSString *)action callback:(YLActionContextCallback)callback;

// keyObject与注册时的keyObject一致才能成功解注册
- (void)unregisterAction:(NSString *)action keyObject:(id)keyObject;
- (void)unregisterAction:(NSString *)action;
- (void)unregisterActionWithKeyObject:(id)keyObject;

- (id)callAction:(NSString *)action data:(id)data;

@end
