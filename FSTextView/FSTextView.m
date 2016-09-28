//
//  FSTextView.m
//  FSTextView
//
//  Created by Steven on 2016/9/27.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "FSTextView.h"

CGFloat const kFSTextViewPlaceholderVerticalMargin  = 8.0; ///< placeholder垂直方向边距
CGFloat const kFSTextViewPlaceholderHorizontalMargin = 6.0; ///< placeholder水平方向边距

@interface FSTextView ()

@property (nonatomic, copy) FSTextViewHandler changeHandler; ///< 文本改变Block
@property (nonatomic, copy) FSTextViewHandler maxHandler; ///< 达到最大限制字符数Block
@property (nonatomic, weak) UILabel *placeholderLabel; ///< placeholderLabel

@end

@implementation FSTextView

#pragma mark - Super Methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        [self layoutIfNeeded];
    }
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _changeHandler = NULL;
    _maxHandler = NULL;
}

#pragma mark - Private

- (void)initialize {
    // 监听文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    // 基本配置
    _maxLength = NSUIntegerMax;
    _placeholderColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];
    
    // 基本设定
    self.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:15.f];
    
    // placeholderLabel
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.font = self.font;
    placeholderLabel.textColor = _placeholderColor;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:placeholderLabel];
    _placeholderLabel = placeholderLabel;
    
    // constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:kFSTextViewPlaceholderVerticalMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:kFSTextViewPlaceholderHorizontalMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-kFSTextViewPlaceholderHorizontalMargin*2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:-kFSTextViewPlaceholderVerticalMargin*2]];
}


#pragma mark - Getter
// SuperGetter
- (NSString *)text {
    NSString *currentText = [super text];
    return [currentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // 去除首尾的空格和换行.
}

#pragma mark - Setter
// SuperStter
- (void)setText:(NSString *)text {
    [super setText:text];
    _placeholderLabel.hidden = [@(text.length) boolValue];
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLabel.font = font;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}
- (void)setBorderColor:(UIColor *)borderColor {
    if (!borderColor) return;
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (!placeholder) return;
    _placeholder = placeholder;
    if (_placeholder.length > 0) {
        _placeholderLabel.text = _placeholder;
    }
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (!placeholderFont) return;
    _placeholderFont = placeholderFont;
    _placeholderLabel.font = _placeholderFont;
}

#pragma mark - NSNotification
- (void)textDidChange:(NSNotification *)notification {
    // 根据字符数量显示或者隐藏placeholderLabel
    _placeholderLabel.hidden = [@(self.text.length) boolValue];
    
    // 禁止第一个字符输入空格或者换行
    if (self.text.length == 1) {
        if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
            self.text = @"";
        }
    }
    
    if (_maxLength != NSUIntegerMax) { // 只有当maxLength字段的值不为无穷大整型时才计算限制字符数.
        NSString    *toBeString    = self.text;
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position   = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > _maxLength) {
                self.text = [toBeString substringToIndex:_maxLength]; // 截取最大限制字符数.
                _maxHandler?_maxHandler(self):NULL; // 回调达到最大限制的Block.
            }
        }
    }
    
    // 回调文本改变的Block.
    _changeHandler?_changeHandler(self):NULL;
}

#pragma mark - Public

/*! @brief 便利构造器创建FSTextView实例.
 */
+ (instancetype)textView {
    return [[self alloc] init];
}

/*! @brief 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextDidChangeHandler:(FSTextViewHandler)changeHandler{
    _changeHandler = [changeHandler copy];
}

/*! @brief 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextLengthDidMaxHandler:(FSTextViewHandler)maxHandler {
    _maxHandler = [maxHandler copy];
}

@end
