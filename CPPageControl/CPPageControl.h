//
//  CPPageControl.h
//  zent
//
//  Created by Morplcp on 2018/4/27.
//  Copyright © 2018年 morplcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *currentTintColor;

@end
