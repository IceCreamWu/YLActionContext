//
//  YLActionContext.m
//  YLActionContextDemo
//
//  Created by IceCreamWu on 2017/5/10.
//  Copyright © 2017年 IceCreamWu. All rights reserved.
//

#import "YLActionContext.h"
#import <libkern/OSAtomic.h>

@interface YLActionContextTarget : NSObject

@property (nonatomic, copy) YLActionContextCallback callback;
@property (nonatomic, weak) id object;

@end

@implementation YLActionContextTarget

@end






@interface YLActionContext ()

@property (nonatomic, strong) NSMutableDictionary *actionTargets;

@end

@implementation YLActionContext {
    OSSpinLock _lock;
}

+ (instancetype)actionContext
{
    static YLActionContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initInstance];
    });
    return instance;
}

- (id)init
{
    NSAssert(NO, @"CCAppContext: cannot call init method, uses sharedInstance!");
    return nil;
}

- (id)initInstance
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _lock = OS_SPINLOCK_INIT;
    self.actionTargets = [[NSMutableDictionary alloc] init];
}

#pragma mark - Public Method
- (void)registerAction:(NSString *)action callback:(YLActionContextCallback)callback keyObject:(id)keyObject
{
    YLActionContextTarget *target = [[YLActionContextTarget alloc] init];
    target.callback = callback;
    if (keyObject)
    {
        target.object = keyObject;
    }
    
    OSSpinLockLock(&_lock);
    [self.actionTargets setObject:target forKey:action];
    OSSpinLockUnlock(&_lock);
}

- (void)registerAction:(NSString *)action callback:(YLActionContextCallback)callback
{
    [self registerAction:action callback:callback keyObject:nil];
}

- (void)unregisterAction:(NSString *)action keyObject:(id)keyObject
{
    YLActionContextTarget *target = [self.actionTargets objectForKey:action];
    if (!target)
    {
        return;
    }
    if (target.object == keyObject || keyObject == nil)
    {
        [self.actionTargets removeObjectForKey:action];
    }
}

- (void)unregisterAction:(NSString *)action
{
    [self unregisterAction:action keyObject:nil];
}

- (void)unregisterActionWithKeyObject:(id)keyObject
{
    OSSpinLockLock(&_lock);
    
    NSMutableArray *removeActions = [[NSMutableArray alloc] init];
    for (NSString *action in self.actionTargets.allKeys)
    {
        YLActionContextTarget *target = [self.actionTargets objectForKey:action];
        if (target.object == keyObject)
        {
            [removeActions addObject:action];
        }
    }
    [self.actionTargets removeObjectsForKeys:removeActions];
    
    OSSpinLockUnlock(&_lock);
}

- (id)callAction:(NSString *)action data:(id)data
{
    YLActionContextTarget *target = [self.actionTargets objectForKey:action];
    if (target && target.callback)
    {
        return target.callback(data);
    }
    return nil;
}

@end
