//
//  ViewController.m
//  FSTextView
//
//  Created by Steven on 2016/9/27.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ViewController.h"
#import "FSTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 达到最大限制时提示的Label
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.font = [UIFont systemFontOfSize:14.f];
    noticeLabel.textColor = UIColor.redColor;
    [self.view addSubview:noticeLabel];
    
    // FSTextView
    FSTextView *textView = [FSTextView textView];
    textView.placeholder = @"这是一个继承于UITextView的带Placeholder的自定义TextView, 可以设定限制字符长度, 以Block形式回调, 简单直观 !";
    textView.borderWidth = 1.f;
    textView.borderColor = UIColor.lightGrayColor;
    textView.cornerRadius = 5.f;
    [self.view addSubview:textView];
    // 限制输入最大字符数.
    textView.maxLength = 10;
    // 弱化引用, 以免造成内存泄露.
    __weak __typeof(&*noticeLabel)weakNoticeLabel = noticeLabel;
    // 添加输入改变Block回调.
    [textView addTextDidChangeHandler:^(FSTextView *textView) {
        (textView.text.length < textView.maxLength) ? weakNoticeLabel.text = @"":NULL;
    }];
    // 添加到达最大限制Block回调.
    [textView addTextLengthDidMaxHandler:^(FSTextView *textView) {
        weakNoticeLabel.text = [NSString stringWithFormat:@"最多限制输入%zi个字符", textView.maxLength];
    }];
    
    // constraint
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    noticeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[textView]-30-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[textView(==100)]-8-[noticeLabel]" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(textView, noticeLabel)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:noticeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
