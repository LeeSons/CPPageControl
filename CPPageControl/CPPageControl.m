//
//  CPPageControl.m
//  zent
//
//  Created by Morplcp on 2018/4/27.
//  Copyright © 2018年 morplcp. All rights reserved.
//

#import "CPPageControl.h"
#define pointWidth 5
#define pointInterval 8

@interface CPPageControl ()

@property (nonatomic, strong) NSMutableArray *pageArray;

@end

@implementation CPPageControl
{
    BOOL _shouldSetColor;
    BOOL _isInit;
    BOOL _inAni; // 是否在动画中
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _tintColor = [UIColor lightGrayColor];
        _currentTintColor = [UIButton buttonWithType:UIButtonTypeSystem].tintColor;
        _shouldSetColor = NO;
        _isInit = YES;
        _inAni = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.pageArray.count == 0) return;
    
    if (_shouldSetColor)
    {
        for (int i = 0; i < self.pageArray.count; i++)
        {
            UIView *view = self.pageArray[i];
            view.backgroundColor = self.tintColor;
            if (i == _currentPage)
            {
                view.backgroundColor = self.currentTintColor;
            }
            _shouldSetColor = NO;
        }
    }
    if (_isInit)
    {
        CGFloat totalWidth = _numberOfPages * pointWidth + (_numberOfPages - 1) * pointInterval;
        for (int i = 0; i < self.pageArray.count; i++)
        {
            
            UIView *view = self.pageArray[i];
            CGFloat x = (self.frame.size.width - totalWidth) * 0.5f + (pointWidth + pointInterval) * i;
            CGFloat y = (self.frame.size.height - pointWidth) * 0.5f;
            CGFloat width = (i==_currentPage?(pointWidth + pointInterval):pointWidth);
            CGFloat height = pointWidth;
            if (i == _currentPage)
            {
                x = x - pointInterval * 0.5f;
            }
            view.frame = CGRectMake(x, y, width, height);
            _isInit = NO;
        }
    }
}

#pragma mark -- setter
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    if (self.pageArray.count > 0)
    {
        [self.pageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             [(UIView *)obj removeFromSuperview];
         }];
        [self.pageArray removeAllObjects];
    }
    for (int i = 0; i < numberOfPages; i++)
    {
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        indicatorView.layer.cornerRadius = pointWidth * 0.5f;
        [self addSubview:indicatorView];
        [self.pageArray addObject:indicatorView];
    }
    
    _shouldSetColor = YES;
    [self setNeedsLayout];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (self.pageArray.count == 0)
    {
        _currentPage = currentPage;
        return;
    }
    if (_currentPage == currentPage) return;
    if (_inAni) return;
    // 向右
    if (currentPage > _currentPage)
    {
        UIView *currentView = self.pageArray[_currentPage];
        UIView *nextView = self.pageArray[currentPage];
        [self bringSubviewToFront:currentView];
        _inAni = YES;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect newFrame = currentView.frame;
            newFrame.size = CGSizeMake((pointInterval + pointWidth) * (currentPage - _currentPage + 1), newFrame.size.height);
            currentView.frame = newFrame;
        } completion:^(BOOL finished)
         {
             [self bringSubviewToFront:nextView];
             currentView.backgroundColor = self.tintColor;
             nextView.backgroundColor = self.currentTintColor;
             CGRect cFrame = currentView.frame;
             nextView.frame = cFrame;
             cFrame.origin = CGPointMake(cFrame.origin.x + pointInterval * 0.5f, cFrame.origin.y);
             cFrame.size = CGSizeMake(pointWidth, pointWidth);
             currentView.frame = cFrame;
             
             [UIView animateWithDuration:0.3 animations:^{
                 CGRect newFrame = nextView.frame;
                 newFrame.size = CGSizeMake(pointInterval + pointWidth, newFrame.size.height);
                 newFrame.origin = CGPointMake(newFrame.origin.x + (pointInterval + pointWidth) * (currentPage - _currentPage), newFrame.origin.y);
                 nextView.frame = newFrame;
             } completion:^(BOOL finished)
              {
                  _currentPage = currentPage;
                  _inAni = NO;
              }];
         }];
    }
    // 向左
    else
    {
        UIView *currentView = self.pageArray[_currentPage];
        UIView *nextView = self.pageArray[currentPage];
        [self bringSubviewToFront:currentView];
        _inAni = YES;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect newFrame = currentView.frame;
            newFrame.size = CGSizeMake((pointInterval + pointWidth) * (_currentPage - currentPage + 1), newFrame.size.height);
            newFrame.origin = CGPointMake(newFrame.origin.x - (pointInterval + pointWidth) * (_currentPage - currentPage), newFrame.origin.y);
            currentView.frame = newFrame;
        } completion:^(BOOL finished)
         {
             [self bringSubviewToFront:nextView];
             currentView.backgroundColor = self.tintColor;
             nextView.backgroundColor = self.currentTintColor;
             CGRect cFrame = currentView.frame;
             nextView.frame = cFrame;
             cFrame.origin = CGPointMake(cFrame.origin.x + pointInterval * 0.5f + (pointInterval + pointWidth) * (_currentPage - currentPage), cFrame.origin.y);
             cFrame.size = CGSizeMake(pointWidth, pointWidth);
             currentView.frame = cFrame;
             
             [UIView animateWithDuration:0.3 animations:^{
                 CGRect newFrame = nextView.frame;
                 newFrame.size = CGSizeMake(pointInterval + pointWidth, newFrame.size.height);
                 nextView.frame = newFrame;
             } completion:^(BOOL finished)
              {
                  _currentPage = currentPage;
                  _inAni = NO;
              }];
         }];
    }
}

- (NSMutableArray *)pageArray
{
    if (!_pageArray)
    {
        _pageArray = [NSMutableArray array];
    }
    return _pageArray;
}

@end
