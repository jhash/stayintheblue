//
//  MyDrinkingScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//NOT FUNCTIONAL

#import "MyDrinkingScreen.h"
#import <QuartzCore/QuartzCore.h>

@interface MyDrinkingScreen ()



@end

@implementation MyDrinkingScreen


@synthesize colorDict;
@synthesize blueNum,maizeNum,redNum,titleLabel;
@synthesize delegate;
@synthesize blue,maize,red;
@synthesize blueCol,maizeCol,redCol;
@synthesize blueFrame,maizeFrame,redFrame;
@synthesize didDraw;

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
	
    
    didDraw = NO;
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.delegate passForwardColorDictionary:self];
}

-(void) viewDidAppear:(BOOL)animated
{
    CALayer *mainLayer = self.view.layer;
    
    
    
    
    
    [self.delegate passForwardColorDictionary:self];
    
    
    
//    red = 2;
//    maize = 1;
//    blue = 3;
    
    
    
    
    //blueNum.text = [NSString stringWithFormat:@"%i", blue];
    //maizeNum.text = [NSString stringWithFormat:@"%i", maize];
    //redNum.text = [NSString stringWithFormat:@"%i", red];
    
    blueCol = [UIColor colorWithRed:.0941 green:.1960 blue:.3411 alpha:1.0];
    maizeCol = [UIColor colorWithRed:.9098 green:.8901 blue:.0745 alpha:1.0];
    redCol = [UIColor colorWithRed:.3176 green:.0588 blue:.0666 alpha:1.0];
    
    NSArray *numArray = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:blue],
                         [NSNumber numberWithInt:maize],
                         [NSNumber numberWithInt:red], nil];
    
    NSNumber *zeroNum = [NSNumber numberWithInt:0];
    
    NSArray *emptyArray = [[NSArray alloc] initWithObjects:zeroNum,zeroNum,zeroNum, nil];
    
    BOOL arrayIsEmpty;
    
    
    blueNum.hidden = YES;
    maizeNum.hidden = YES;
    redNum.hidden = YES;
    
    
    
    //make text and animations
    
    
    
    if([numArray isEqualToArray:emptyArray])
    {
        arrayIsEmpty = YES;  
        titleLabel.text = @"You don't have any saved sessions yet!";
       // titleLabel.font.s
        
    }
    else
    {
        arrayIsEmpty = NO;
    }
    
    
    
    double maxVal = [[numArray valueForKeyPath:@"@max.intValue"] doubleValue];
    double scalar = ((1.0/maxVal)*100.0);
    
    
    double blueheight = blue*scalar*2;
    double maizeHeight = maize*scalar*2;
    double redHeight = red*scalar*2;
    
    
    
    if(!didDraw && !arrayIsEmpty)
    {
        
        titleLabel.text = @"Your drinking history";
        
        NSLog(@"%i, %i, %i", blue, maize, red);
        
        
        
        
        
        
/*---------------------------DRAW BLUE BAR-----------------------------------*/
        
        CGRect blueBarSize = blueFrame.frame;
        
        
        CALayer *blueBar = [CALayer layer];
        blueBar.backgroundColor = blueCol.CGColor;
        blueBar.shadowOffset = CGSizeMake(0, 3);
        blueBar.shadowRadius = 5.0;
        blueBar.shadowColor = [UIColor blackColor].CGColor;
        blueBar.shadowOpacity = 0.8;
        //CGPoint blueOrigin = CGPointMake(44,451);
        
        
        
        
        //testing
        NSLog(@"The height of blue is: %f", blueheight);


        
        blueBar.frame = CGRectMake(44,
                                   (351 + blueheight*.5),
                                    blueBarSize.size.width,
                                    blueheight);
        
        
        //NSLog(@"The origin of the graph is %@", NSStringFromCGPoint(blueBar.frame.origin));
        
        NSLog(@"The origin of the graph is %@", NSStringFromCGPoint(blueBar.frame.origin));
        [mainLayer addSublayer:blueBar];
        
        
        
        
/*--------------------------DRAW MAIZE BAR-----------------------------------*/
        
        CALayer *maizeBar = [CALayer layer];
        maizeBar.backgroundColor = maizeCol.CGColor;
        maizeBar.shadowOffset = CGSizeMake(0, 3);
        maizeBar.shadowRadius = 5.0;
        maizeBar.shadowColor = [UIColor blackColor].CGColor;
        maizeBar.shadowOpacity = 0.8;
        
        
        
        CGRect maizeBarSize = maizeFrame.frame;
        maizeBar.frame = CGRectMake(132,
                                    (351 + maizeHeight *.5), //try inserting blueheight prop
                                    maizeBarSize.size.width,
                                    maizeHeight);
        [mainLayer addSublayer:maizeBar];
        
        NSLog(@"The origin of the graph is %@", NSStringFromCGPoint(maizeBar.frame.origin));
        maizeBar.anchorPoint = CGPointMake(.5, 1.0);
        NSLog(@"The origin of the graph is %@", NSStringFromCGPoint(maizeBar.frame.origin));
        
        
        
/*--------------------------DRAW RED BAR-------------------------------------*/
        
        CALayer *redBar = [CALayer layer];
        redBar.backgroundColor = redCol.CGColor;
        redBar.shadowOffset = CGSizeMake(0, 3);
        redBar.shadowRadius = 5.0;
        redBar.shadowColor = [UIColor blackColor].CGColor;
        redBar.shadowOpacity = 0.8;
        
        
        
        CGRect redBarSize = redFrame.frame;
        redBar.frame = CGRectMake(222,
                                  (251 + redHeight * .5),
                                  redBarSize.size.width,
                                  redHeight);
        
        [mainLayer addSublayer:redBar];
        
        
        
        
        //-----------ANIMATE
        
        
        CABasicAnimation *scaleBars = [CABasicAnimation animationWithKeyPath:@"transform"];
        scaleBars.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0, 1)];
        scaleBars.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
        scaleBars.duration = 1;
        scaleBars.repeatCount = 0;
        scaleBars.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        
        //---glow animation
        CABasicAnimation *glowPulse = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        glowPulse.fromValue = [NSNumber numberWithDouble:5.0];
        glowPulse.toValue = [NSNumber numberWithDouble: 10.0];
        glowPulse.duration = 1;
        glowPulse.repeatDuration = INFINITY;
        glowPulse.autoreverses = YES;
        glowPulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        
        
        //Change anchor points, start animations
        blueBar.anchorPoint = CGPointMake(.5, 1.0);
        blueBar.position = CGPointMake(72, 351);
        [blueBar addAnimation:scaleBars forKey:@"transform"];
        //[blueBar addAnimation:glowPulse forKey:@"shadowRadius"];
        
        maizeBar.anchorPoint = CGPointMake(.5, 1.0);
        maizeBar.position = CGPointMake(160, 351);
        [maizeBar addAnimation:scaleBars forKey:@"transform"];
        //[maizeBar addAnimation:glowPulse forKey:@"shadowRadius"];
        
        redBar.anchorPoint = CGPointMake(.5, 1.0);
        redBar.position = CGPointMake(250, 351);
        [redBar addAnimation:scaleBars forKey:@"transform"];
        //[redBar addAnimation:glowPulse forKey:@"shadowRadius"];
        
        
        
        
        
        didDraw = YES;
        
        
       
        //--------------make text and animate it
        
        
        
        
        
        //---blue
        CATextLayer * blueText = [self makeTextLayer:blue];
        [mainLayer addSublayer:blueText];
        blueText.anchorPoint = CGPointMake(.5, 1.0);
        blueText.frame = CGRectMake(72, 351, 100, 50);
        CGPoint blueStart = CGPointMake(72, 361);
        CGPoint blueEnd = CGPointMake(72, (361-blueheight));
        CABasicAnimation *blueNumAnim = [self makeNumberAnimation:blueStart
                                                   endPosition:blueEnd];
        [blueText addAnimation:blueNumAnim forKey:@"position"];
        blueText.position = blueEnd;
        
        
        NSArray *blueTextAndNum = [[NSArray alloc] initWithObjects:blueText,
                                  [NSNumber numberWithInt:blue], nil];
        NSTimer *blueNumTimer = [NSTimer scheduledTimerWithTimeInterval:(.8/(double)blue)
                                                              target:self
                                                            selector:@selector(numTimer:)
                                                            userInfo:blueTextAndNum
                                                             repeats:YES];
        
        
        //---maize
        CATextLayer * maizeText = [self makeTextLayer:maize];
        [mainLayer addSublayer:maizeText];
        maizeText.anchorPoint = CGPointMake(.5, 1.0);
        maizeText.frame = CGRectMake(160, 351, 100, 50);
        CGPoint maizeStart = CGPointMake(160, 361);
        CGPoint maizeEnd = CGPointMake(160, (361 - maizeHeight));
        CABasicAnimation *maizeNumAnim = [self makeNumberAnimation:maizeStart
                                                       endPosition:maizeEnd];
        [maizeText addAnimation:maizeNumAnim forKey:@"position"];
        maizeText.position = maizeEnd;
        
        
        NSArray *maizeTextAndNum = [[NSArray alloc] initWithObjects:maizeText, [NSNumber numberWithInt:maize], nil];
        NSTimer *maizeNumTimer = [NSTimer scheduledTimerWithTimeInterval:(.8/(double)maize)
                                                                  target:self
                                                                selector:@selector(numTimer:)
                                                                userInfo:maizeTextAndNum
                                                                 repeats:YES];
        
        
        //---red
        CATextLayer *redText = [self makeTextLayer:red];
        [mainLayer addSublayer:redText];
        redText.anchorPoint = CGPointMake(.5, 1.0);
        redText.frame = CGRectMake(250, 351, 100, 50);
        CGPoint redStart = CGPointMake(250, 361);
        CGPoint redEnd = CGPointMake(250, (361 - redHeight));
        CABasicAnimation *redNumAnim = [self makeNumberAnimation:redStart
                                                     endPosition:redEnd];
        [redText addAnimation:redNumAnim forKey:@"position"];
        redText.position = redEnd;
        
        
        NSArray *redTextAndNum = [[NSArray alloc] initWithObjects:redText, [NSNumber numberWithInt:red], nil];
        NSTimer *redNumTimer = [NSTimer scheduledTimerWithTimeInterval:(.8/(double)red)
                                                                  target:self
                                                                selector:@selector(numTimer:)
                                                                userInfo:redTextAndNum
                                                                 repeats:YES];
    }
}


-(void) numTimer: (NSTimer *) t
{
    NSArray *TextAndNum = [t userInfo];
    int max = [[TextAndNum objectAtIndex:1] integerValue];
    CATextLayer *blueText = [TextAndNum objectAtIndex:0];
    
    int currentVal = [blueText.string integerValue];
    
    //int interval = (100/max);
    
    if(currentVal < max)
    {
        blueText.string = [NSString stringWithFormat:@"%i", currentVal+1];
    }
    else
    {
        [t invalidate];
    }
}


-(CABasicAnimation *) makeNumberAnimation:(CGPoint) startPos
                            endPosition: (CGPoint) endPos

{
    CABasicAnimation * thisAnim = [CABasicAnimation
                                   animationWithKeyPath:@"position"];
    thisAnim.fromValue = [NSValue valueWithCGPoint:startPos];
    thisAnim.toValue = [NSValue valueWithCGPoint:endPos];
    thisAnim.duration = 1;
    thisAnim.timingFunction = [CAMediaTimingFunction
                               functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    thisAnim.repeatCount = 0;
                          
    
    return thisAnim;
    
}


- (CATextLayer *) makeTextLayer: (int) num
{
    CATextLayer *thisText = [CATextLayer layer];
    CGFontRef font = CGFontCreateWithFontName((CFStringRef)@"Avenir-Black");
    thisText.font = font;
    thisText.fontSize = 20.0;
    thisText.alignmentMode = kCAAlignmentCenter;
    thisText.foregroundColor = [UIColor whiteColor].CGColor;
    thisText.string = [NSString stringWithFormat:@"%i", 0];
    
    
    return thisText;
}



-(void) viewDidDisappear:(BOOL)animated
{
    NSIndexSet *textLayerIndices = [self.view.layer.sublayers indexesOfObjectsPassingTest:
                            ^(id obj, NSUInteger idx, BOOL *stop){
                              return [obj isMemberOfClass:[CATextLayer class]];
                            }];
    NSIndexSet *shapeLayerIndices = [self.view.layer.sublayers indexesOfObjectsPassingTest:
                                     ^(id obj, NSUInteger idx, BOOL *stop){
                                         return [obj isMemberOfClass:[CALayer class]];
                                     }];
    
    NSArray *textLayers = [self.view.layer.sublayers objectsAtIndexes:textLayerIndices];
    NSArray *shapeLayers = [self.view.layer.sublayers objectsAtIndexes:shapeLayerIndices];
    
    for(CATextLayer *tL in textLayers)
    {
        [tL removeFromSuperlayer];
    }
    for(CALayer *sL in shapeLayers)
    {
        if(sL.shadowRadius == 5.0)
        {
            [sL removeFromSuperlayer];
        }
    }
    
    didDraw = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
