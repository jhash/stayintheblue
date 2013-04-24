//
//  undoButton.m
//  SIB
//
//  Created by Steven Coffey on 3/31/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "undoButton.h"

@implementation undoButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Polygon 2 Drawing
    UIBezierPath* polygon2Path = [UIBezierPath bezierPath];
    [polygon2Path moveToPoint: CGPointMake(66, 65)];
    [polygon2Path addLineToPoint: CGPointMake(66, 65)];
    [polygon2Path addLineToPoint: CGPointMake(66, 65)];
    [polygon2Path closePath];
    [strokeColor setFill];
    [polygon2Path fill];
    
    
    //// Group
    {
        //// Oval Drawing
        CGRect ovalRect = CGRectMake(51.5, 49.5, 17, 18);
        UIBezierPath* ovalPath = [UIBezierPath bezierPath];
        [ovalPath addArcWithCenter: CGPointMake(0, 0) radius: CGRectGetWidth(ovalRect) / 2 startAngle: 205 * M_PI/180 endAngle: 90 * M_PI/180 clockwise: YES];
        
        CGAffineTransform ovalTransform = CGAffineTransformMakeTranslation(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect));
        ovalTransform = CGAffineTransformScale(ovalTransform, 1, CGRectGetHeight(ovalRect) / CGRectGetWidth(ovalRect));
        [ovalPath applyTransform: ovalTransform];
        
        [fillColor setStroke];
        ovalPath.lineWidth = 2.5;
        [ovalPath stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(49.21, 58.99)];
        [bezierPath addLineToPoint: CGPointMake(54.93, 56.06)];
        [bezierPath addLineToPoint: CGPointMake(49.5, 52.44)];
        [bezierPath addLineToPoint: CGPointMake(49.21, 58.99)];
        [bezierPath closePath];
        [fillColor setFill];
        [bezierPath fill];
    }

}


@end
