//
//  ToDoA2Screen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ToDoA2Screen : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIImageView *toDoLoad;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;

@property Reachability *internetReachable;

@end
