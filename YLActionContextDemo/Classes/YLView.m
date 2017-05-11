//
//  YLView.m
//  YLActionContextDemo
//
//  Created by IceCreamWu on 2017/5/10.
//  Copyright © 2017年 IceCreamWu. All rights reserved.
//

#import "YLView.h"
#import "YLSubView.h"

@interface YLView ()

@property (nonatomic, strong) YLSubView *subView;

@end

@implementation YLView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        [self addSubview:self.subView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.subView.frame = CGRectMake(20, 20, w - 40, h - 40);
}

- (YLSubView *)subView {
    if (!_subView) {
        _subView = [[YLSubView alloc] init];
    }
    return _subView;
}

@end
