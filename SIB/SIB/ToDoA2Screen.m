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
    self.WebView.hidden = YES; //hide web view while loading
    [loadIndicator startAnimating]; //start the activity indicator
    self.toDoLoad.image = [UIImage imageNamed:@"toDoLoad.png"]; //load background image
    
    //load array with fun loading text
    NSArray *loadingTextArray = [NSArray arrayWithObjects:@"Searching Interwebs", @"Phoning Little Birds," @"Putting Ear to Ground", @"Texting Buddies", @"Asking Mom" ,@"Reading Newspaper", @"Calling Friend From Philly", nil];
    
    //generate random number for loading text index
    int randomNum = arc4random_uniform([loadingTextArray count]);
    NSLog(@"%i", randomNum);
    
    //display text at random index
    self.loadingText.text = [loadingTextArray objectAtIndex:randomNum];
    
    //display webpage
    NSURL * toDoA2URL = [NSURL URLWithString:@"http://www.todoina2.com"];
    NSURLRequest *toDoRequest = [NSURLRequest requestWithURL:toDoA2URL];
	[self.WebView loadRequest:toDoRequest];
    
    //create timer to hide webview for 4 seconds
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(stopLoading:) userInfo:nil repeats:NO];
    if(self.WebView.loading)
    {
        //run the loop while webview is loading
        [[NSRunLoop currentRunLoop] run];
        if(self.WebView.loading) // if still loading
        {
            [[NSRunLoop currentRunLoop] run];
        }
    }
    
    
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
