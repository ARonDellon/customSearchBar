//
//  kSearchBar.h
//  ZBCool
//
//  Created by wangweiyi on 16/5/24.
//  Copyright © 2016年 i-chou. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol kSearchBarDelegate;
@class kTextField;

@interface kSearchBar : UIView

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  get all infomations from this textField.  e.g. text
 */
@property (nonatomic,strong,readonly)kTextField *searchTextField;

/**
 *  search textField property
 */
@property (nonatomic,assign)CGRect searchTextFieldFrame;
@property (nonatomic,assign)CGFloat searchTextFieldCornerRadius;
@property (nonatomic,strong)UIColor *searchTextColor;
@property (nonatomic,strong)UIFont *searchTextFont;
@property (nonatomic,assign)NSTextAlignment searchTextAlignment;


/**
 *  placeHolder property
 */
@property (nonatomic,copy)NSString *placeHolderStr;
@property (nonatomic,strong)UIFont * placeHolderFont;
@property (nonatomic,strong)UIColor *placeHolderTextColor;
@property (nonatomic,assign)NSTextAlignment placeHolderTextAlignment;

/**
 *  delegate below
 */
@property (nonatomic,weak)id<kSearchBarDelegate>delegate;


@end



@protocol kSearchBarDelegate <NSObject>

/**
 *  called when text in textField changed
 *
 *  @param searchBar  self
 *  @param searchText text
 */
- (void)kSearchBar:(kSearchBar *)searchBar textDidChange:(nonnull NSString *)searchText;

/**
 *  called when return in keyboard clicked
 *
 *  @param searchBar  self
 *  @param searchText text
 */
- (void)kSearchBar:(kSearchBar *)searchBar didClickSearchBtn:(nonnull NSString *)searchText;


@end


/**
 *  custom textField ,  convenient to change placeHolder property
 */
@interface kTextField : UITextField

@property (nonatomic,strong)UIFont * placeHolderFont;
@property (nonatomic,strong)UIColor *placeHolderTextColor;
@property (nonatomic,assign)NSTextAlignment placeHolderTextAlignment;


@end
