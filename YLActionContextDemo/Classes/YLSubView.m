//
//  YLSubView.m
//  YLActionContextDemo
//
//  Created by IceCreamWu on 2017/5/10.
//  Copyright © 2017年 IceCreamWu. All rights reserved.
//

#import "YLSubView.h"

NSString *kYLSubViewTitle = @"SubView Title";

@interface YLSubView ()

@property (nonatomic, strong) UILabel  *textLabel;
@property (nonatomic, strong) UIButton *getTitleBtn;
@property (nonatomic, strong) UIButton *setTitleBtn;
@property (nonatomic, strong) UIButton *resetBtn;

@end

@implementation YLSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        [self addSubview:self.textLabel];
        [self addSubview:self.getTitleBtn];
        [self addSubview:self.setTitleBtn];
        [self addSubview:self.resetBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    
    self.textLabel.frame = CGRectMake(0, 0, w, 40);
    self.getTitleBtn.frame = CGRectMake(20, 60, w - 40, 90);
    self.setTitleBtn.frame = CGRectMake(20, 170, w - 40, 90);
    self.resetBtn.frame = CGRectMake(20, 280, w - 40, 90);
}

#pragma mark - Event
- (void)didClickGetTitle {
    NSString *title = [[YLActionContext actionContext] callAction:YL_ACTION_GET_TITLE data:nil];
    self.textLabel.text = title ?: @"";
}

- (void)didClickSetTitle {
    [[YLActionContext actionContext] callAction:YL_ACTION_SET_TITLE data:kYLSubViewTitle];
}

- (void)didClickReset {
    self.textLabel.text = kYLSubViewTitle;
    [[YLActionContext actionContext] callAction:YL_ACTION_RESET_TITLE data:nil];
}

#pragma mark - Getter
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = kYLSubViewTitle;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

- (UIButton *)getTitleBtn {
    if (!_getTitleBtn) {
        _getTitleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_getTitleBtn setTitle:@"Get Title" forState:UIControlStateNormal];
        [_getTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getTitleBtn setBackgroundColor:[UIColor blackColor]];
        [_getTitleBtn sizeToFit];
        [_getTitleBtn addTarget:self action:@selector(didClickGetTitle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getTitleBtn;
}

- (UIButton *)setTitleBtn {
    if (!_setTitleBtn) {
        _setTitleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_setTitleBtn setTitle:@"Set Title" forState:UIControlStateNormal];
        [_setTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_setTitleBtn setBackgroundColor:[UIColor blackColor]];
        [_setTitleBtn sizeToFit];
        [_setTitleBtn addTarget:self action:@selector(didClickSetTitle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setTitleBtn;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resetBtn setTitle:@"Reset Title" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_resetBtn setBackgroundColor:[UIColor blackColor]];
        [_resetBtn sizeToFit];
        [_resetBtn addTarget:self action:@selector(didClickReset) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

@end
