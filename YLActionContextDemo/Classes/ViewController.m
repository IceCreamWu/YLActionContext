//
//  ViewController.m
//  YLActionContextDemo
//
//  Created by IceCreamWu on 2017/5/10.
//  Copyright © 2017年 IceCreamWu. All rights reserved.
//

#import "ViewController.h"
#import "YLView.h"

NSString *kViewControllerTitle = @"ViewController Title";

@interface ViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YLView  *ylView;

@end

@implementation ViewController

- (void)dealloc {
    [[YLActionContext actionContext] unregisterActionWithKeyObject:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.ylView];
    
    __weak typeof(self) wSelf = self;
    
    YLActionContext *kYLActionContext = [YLActionContext actionContext];
    [kYLActionContext registerAction:YL_ACTION_GET_TITLE callback:^id(id data) {
        return kViewControllerTitle;
    } keyObject:self];
    
    [kYLActionContext registerAction:YL_ACTION_SET_TITLE callback:^id(id data) {
        if ([data isKindOfClass:[NSString class]]) {
            wSelf.titleLabel.text = data;
            return @(YES);
        }
        return @(NO);
    } keyObject:self];
    
    [kYLActionContext registerAction:YL_ACTION_RESET_TITLE callback:^id(id data) {
        wSelf.titleLabel.text = kViewControllerTitle;
        return nil;
    } keyObject:self];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    self.titleLabel.frame = CGRectMake(20, 20, w - 40, 40);
    self.ylView.frame = CGRectMake(20, 70, w - 40, h - 80);
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = kViewControllerTitle;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (YLView *)ylView {
    if (!_ylView) {
        _ylView = [[YLView alloc] initWithFrame:self.view.bounds];
    }
    return _ylView;
}
    
#pragma mark - Test
- (void)test {
    
    // 消息接收者
    YLActionContext *kYLActionContext = [YLActionContext actionContext];
    [kYLActionContext registerAction:@"actionName" callback:^id(id data) {
        NSLog(@"%@", data);
        return @"Message From Receiver!";
    } keyObject:self];
    
    
    // 消息发送者（调用者）
    id data = [[YLActionContext actionContext] callAction:@"actionName" data:@"Message From Sender!"];
    NSLog(@"%@", data);
}


@end
