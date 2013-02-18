//
//  ToDoA2Screen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "ToDoA2Screen.h"

@interface ToDoA2Screen ()

@end

@implementation ToDoA2Screen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL * toDoA2URL = [NSURL URLWithString:@"http://www.todoina2.com"];
    NSURLRequest *toDoRequest = [NSURLRequest requestWithURL:toDoA2URL];
	[self.WebView loadRequest:toDoRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
