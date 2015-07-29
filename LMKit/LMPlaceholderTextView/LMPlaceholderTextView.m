//
//  LMPlaceholderTextView.m
//  LMPlaceholderTextView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMPlaceholderTextView.h"

@interface LMPlaceholderTextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation LMPlaceholderTextView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self insertSubview:self.placeholderLabel atIndex:0];
    
    self.placeholderLabel.hidden = YES;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.userInteractionEnabled = NO;
        _placeholderLabel.font = self.font;
        _placeholderLabel.text = NSLocalizedString(@"Input...", nil);
        [_placeholderLabel sizeToFit];
    }
    
    return _placeholderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self updatePlaceholderLabelVisibility];
}

- (NSString *)placeholder
{
    return self.placeholderLabel.text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
}

- (void)updatePlaceholderLabelVisibility
{
    self.placeholderLabel.hidden = self.text.length;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self caretRectForPosition:self.beginningOfDocument];
}

- (UITextRange *)selectedTextRange
{
    [self updatePlaceholderLabelVisibility];
    
    return [super selectedTextRange];
}

- (UITextRange *)markedTextRange
{
    [self updatePlaceholderLabelVisibility];
    
    return [super markedTextRange];
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect caretRect = [super caretRectForPosition:position];
    
    [self updatePlaceholderLabelVisibility];
    
    if ([self.text length] == 0) {
        
        [self.placeholderLabel sizeToFit];
        CGRect rect = CGRectZero;
        rect.size = self.placeholderLabel.frame.size;
        rect.origin = caretRect.origin;
        self.placeholderLabel.frame = rect;
    }
    
    return caretRect;
}

@end
