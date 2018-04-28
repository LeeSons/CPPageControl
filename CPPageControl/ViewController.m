//
//  ViewController.m
//  CPPageControl
//
//  Created by 孙登峰 on 2018/4/27.
//  Copyright © 2018年 morplcp. All rights reserved.
//

#import "ViewController.h"
#import "CPPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) CPPageControl *page;

@end

@implementation ViewController
{
    int _currentPage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentPage = 0;
    _page = [[CPPageControl alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    _page.numberOfPages = 4;
    [self.view addSubview:_page];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"往左" forState:UIControlStateNormal];
    [button1 setFrame:CGRectMake(50, 150, 100, 50)];
    [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.backgroundColor = button1.tintColor;
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"往右" forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(self.view.frame.size.width - 50 - 100, 150, 100, 50)];
    [button2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.backgroundColor = button2.tintColor;
    [self.view addSubview:button2];
}

- (void)click:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"往左"])
    {
        if (_currentPage == 0)
        {
            _currentPage = 3;
        }
        else
        {
            _currentPage--;
        }
        _page.currentPage = _currentPage;
    }
    else
    {
        if (_currentPage == 3)
        {
            _currentPage = 0;
        }
        else
        {
            _currentPage++;
        }
        _page.currentPage = _currentPage;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
