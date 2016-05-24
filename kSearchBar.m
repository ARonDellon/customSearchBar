//
//  kSearchBar.m
//  ZBCool
//
//  Created by wangweiyi on 16/5/24.
//  Copyright © 2016年 i-chou. All rights reserved.
//

#define COLORRGB(c)    [UIColor colorWithRed:((c>>16)&0xFF)/255.0	\
green:((c>>8)&0xFF)/255.0	\
blue:(c&0xFF)/255.0         \
alpha:1.0]


#import "kSearchBar.h"

CGFloat const widthPadding = 10;

@interface kSearchBar ()<UITextFieldDelegate>

@property (nonatomic,strong,readwrite)kTextField *searchTextField;

@end

@implementation kSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.searchTextField];
        self.searchTextFieldCornerRadius = 5;
        [self addObserve];
    }
    return self;
}

/**
 *  the min heigh of self is 30px , so if u want the padding for top and bottom , pls set height more than 30px
 *
 *  @param frame frame
 */
- (void)setFrame:(CGRect)frame {

    if (frame.size.height<30) {
        frame.size.height = 30;
    }
    [super setFrame:frame];

    CGRect textFieldFrame = CGRectMake(widthPadding,
                                       (self.bounds.size.height-30)/2,
                                       (self.bounds.size.width-widthPadding*2),
                                       30);
    [self setSearchTextFieldFrame:textFieldFrame];

}

/**
 *  textField setter
 */

- (void)setSearchTextFieldFrame:(CGRect)searchTextFieldFrame {
    _searchTextFieldFrame = searchTextFieldFrame;
    self.searchTextField.frame = searchTextFieldFrame;
}

- (void)setSearchTextFieldCornerRadius:(CGFloat)searchTextFieldCornerRadius {
    _searchTextFieldCornerRadius = searchTextFieldCornerRadius;
    self.searchTextField.layer.cornerRadius = searchTextFieldCornerRadius;
}

- (void)setSearchTextFont:(UIFont *)searchTextFont {
    _searchTextFont = searchTextFont;
    self.searchTextField.font = searchTextFont;
}

- (void)setSearchTextColor:(UIColor *)searchTextColor {
    _searchTextColor = searchTextColor;
    self.searchTextField.textColor = searchTextColor;
}

- (void)setSearchTextAlignment:(NSTextAlignment)searchTextAlignment {
    _searchTextAlignment = searchTextAlignment;
    self.searchTextField.textAlignment = searchTextAlignment;
}

/**
 *  placeHolder setter
 */

- (void)setPlaceHolderStr:(NSString *)placeHolderStr {
    _placeHolderStr = placeHolderStr;
    self.searchTextField.placeholder = placeHolderStr;
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont {
    [self.searchTextField setPlaceHolderFont:placeHolderFont];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    [self.searchTextField setPlaceHolderTextColor:placeHolderTextColor];
}

- (void)setPlaceHolderTextAlignment:(NSTextAlignment)placeHolderTextAlignment {
    [self.searchTextField setPlaceHolderTextAlignment:placeHolderTextAlignment];
}


/**
 *  an observe for text changed in textField
 */
- (void)addObserve {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}



- (void)textFieldDidChange {

    if ([self.delegate respondsToSelector:@selector(kSearchBar:textDidChange:)]) {
        [self.delegate kSearchBar:self textDidChange:self.searchTextField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(kSearchBar:didClickSearchBtn:)]) {
        [self.delegate kSearchBar:self didClickSearchBtn:textField.text];
    }
    return YES;
}


/**
 *  lazy load textField
 *
 *  @return textField
 */
- (kTextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[kTextField alloc]init];
        _searchTextField.delegate = self;
        _searchTextField.backgroundColor = COLORRGB(0xf0f0f0);
        _searchTextField.returnKeyType = UIReturnKeySearch;
    }
    return _searchTextField;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:nil];
}


@end



/**
 *  custom textField
 */
@implementation kTextField


@synthesize placeHolderFont = _placeHolderFont;
@synthesize placeHolderTextColor = _placeHolderTextColor;
@synthesize placeHolderTextAlignment = _placeHolderTextAlignment;

- (void)setPlaceHolderTextAlignment:(NSTextAlignment)placeHolderTextAlignment {
    _placeHolderTextAlignment = placeHolderTextAlignment;
    [self drawPlaceholderInRect:self.bounds];
}


- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    _placeHolderTextColor = placeHolderTextColor;
    [self drawPlaceholderInRect:self.bounds];
}


- (void)setPlaceHolderFont:(UIFont *)placeHolderFont {
    _placeHolderFont = placeHolderFont;
    [self drawPlaceholderInRect:self.bounds];
}

- (UIFont *)placeHolderFont {
    if (!_placeHolderFont) {
        _placeHolderFont = [UIFont systemFontOfSize:12];
    }
    return _placeHolderFont;
}

- (UIColor *)placeHolderTextColor {
    if (!_placeHolderTextColor) {
        _placeHolderTextColor = COLORRGB(0x787878);
    }
    return _placeHolderTextColor;
}

- (NSTextAlignment)placeHolderTextAlignment {
    if (!_placeHolderTextAlignment) {
        _placeHolderTextAlignment = NSTextAlignmentLeft;
    }
    return _placeHolderTextAlignment;
}


/**
 *  reDraw the placeHolder
 */
- (void)drawPlaceholderInRect:(CGRect)rect {
    [self.placeHolderTextColor setFill];

    CGRect placeholderRect = CGRectMake(rect.origin.x+10,
                                        (rect.size.height- self.placeHolderFont.pointSize)/2 - 2,
                                        rect.size.width-20,
                                        self.placeHolderFont.pointSize+4);
    rect = placeholderRect;

    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.placeHolderTextAlignment;

    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          style,NSParagraphStyleAttributeName,
                          self.placeHolderFont,
                          NSFontAttributeName,
                          self.placeHolderTextColor,
                          NSForegroundColorAttributeName, nil];

    [self.placeholder drawInRect:rect withAttributes:attr];

}




@end






















