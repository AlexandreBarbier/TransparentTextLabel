//
//  ViewController.m
//  TransparentTextLabel
//
//  Created by Alexandre barbier on 17/05/14.
//  Copyright (c) 2014 Alexandre barbier. All rights reserved.
//

#import "ViewController.h"
#import "TransparentTextLabel.h"

@interface ViewController ()
/**
 *  @name Properties
 */
/**
 *  First label
 */
@property (weak, nonatomic) IBOutlet TransparentTextLabel *firstLabel;
/**
 *  Second label
 */
@property (weak, nonatomic) IBOutlet TransparentTextLabel *secondLabel;
/**
 *  background layer to show gradient
 */
@property (nonatomic, strong) CAGradientLayer *bgLayer;
/**
 *  gradient colors
 */
@property (nonatomic, strong) NSArray *gradientColors;
/**
 *  index of the next gradient color
 */
@property (nonatomic, assign) NSInteger nextIndex;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // here we have to put a backround to our label if we want to see the text
    // self.firstLabel.backgroundColor = [UIColor whiteColor];
    self.secondLabel.backgroundColor = [UIColor blackColor];
    
    // bacground layer initialisation
    _bgLayer = [[CAGradientLayer alloc] init];
    self.bgLayer.frame = [[UIScreen mainScreen] bounds];
    self.bgLayer.name = @"colorGradient";
    
    // first color end at the middle of the screen
    [self.bgLayer setStartPoint:CGPointMake(1, 0.5)];
    [self.bgLayer setEndPoint:CGPointMake(1, 1)];
    
    // gradient colors initialisation
    self.gradientColors = @[@[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor], @[(id)[UIColor purpleColor].CGColor, (id)[UIColor blueColor].CGColor]];
    
    // insert our background layer in the layer's view
    [self.view.layer insertSublayer:self.bgLayer atIndex:0];
    
    // add timer to change the background every 3 seconds
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
    [timer fire];
}

/**
 *  switch the gradient color with a fade animation
 */
- (void)changeBackground {
    CATransition *colorChangeTransition = [CATransition animation];
    [colorChangeTransition setType:kCATransitionFade];
    [colorChangeTransition setDuration:1.8];
    [colorChangeTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [colorChangeTransition setFillMode:kCAFillModeBoth];
    [self.bgLayer removeAnimationForKey:@"colorChange"];
    [self.bgLayer addAnimation:colorChangeTransition forKey:@"colorChange"];
    self.bgLayer.colors = self.gradientColors[self.nextIndex++];
    if (self.nextIndex == 2) {
        self.nextIndex= 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
