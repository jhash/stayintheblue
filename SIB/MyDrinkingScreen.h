//
//  MyDrinkingScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@class  MyDrinkingScreen;
@protocol MyDrinkingScreenDelegate <NSObject>

- (void) passForwardColorDictionary: (MyDrinkingScreen*) mds;

@end

@interface MyDrinkingScreen : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *blueFrame;
@property (weak, nonatomic) IBOutlet UIImageView *maizeFrame;
@property (weak, nonatomic) IBOutlet UIImageView *redFrame;


@property NSDictionary *colorDict;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *blueNum;
@property (weak, nonatomic) IBOutlet UILabel *maizeNum;
@property (weak, nonatomic) IBOutlet UILabel *redNum;
@property (nonatomic, weak) id <MyDrinkingScreenDelegate> delegate;

@property int blue;
@property int maize;
@property int red;
@property BOOL didDraw;

@property UIColor *blueCol;
@property UIColor *maizeCol;
@property UIColor *redCol;



@end
