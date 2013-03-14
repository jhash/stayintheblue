//
//  ToDoA2Screen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//FUNCTIONAL SCREEN -- 2.19



#import "ToDoA2Screen.h"

@interface ToDoA2Screen ()

@end

@implementation ToDoA2Screen
@synthesize loadIndicator;

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
    
    

}




- (void) viewDidAppear:(BOOL)animated
{
    
    
    
    
    //display webpage
    [self start_Web_View];
    
    
    
    
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.WebView.hidden = YES;
    self.toDoLoad.hidden = NO;
    self.loadIndicator.hidden = NO;
    self.loadIndicator.hidden = NO;
    [loadIndicator startAnimating];
}

-(void) start_Web_View
{
    self.WebView.delegate = self;
    NSURL * toDoA2URL = [NSURL URLWithString:@"http://www.todoina2.com"];
    NSURLRequest *toDoRequest = [NSURLRequest requestWithURL:toDoA2URL];
	[self.WebView loadRequest:toDoRequest];
    
    self.WebView.hidden = YES;
    [loadIndicator startAnimating];
    self.toDoLoad.image = [UIImage imageNamed:@"toDoLoad.png"]; //load background image
    
    //load array with fun loading text
    NSArray *loadingTextArray = [NSArray arrayWithObjects:@"Searching Interwebs", @"Phoning Little Birds", @"Putting Ear to Ground", @"Texting Buddies", @"Asking Mom" ,@"Reading Newspaper", @"Calling Friend From Philly", @"Searching Farmer's Almanac", nil];
    
    //generate random number for loading text index
    int randomNum = arc4random_uniform([loadingTextArray count]);
    NSLog(@"%i", randomNum);
    
    //display text at random index
    self.loadingText.text = [loadingTextArray objectAtIndex:randomNum];
    
    
    if(self.WebView.loading)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           for (int i = 0; i < 10; i++){
                               int otherRandomNum = arc4random_uniform([loadingTextArray count]);
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.loadingText.text = [loadingTextArray objectAtIndex:otherRandomNum];
                               });
                               sleep(1);
                           }
                       });
    }
    
    
    
}


#pragma mark webview delegate
-(void) webViewDidFinishLoad: (UIWebView *) webView
{
    self.WebView.hidden = NO;
    [loadIndicator stopAnimating];
    self.toDoLoad.hidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                  
- (void) stopLoading: (NSTimer *) t
{
    [loadIndicator stopAnimating];
    self.WebView.hidden = NO;
}

@end
