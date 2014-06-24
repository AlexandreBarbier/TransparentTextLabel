//
//  TransparentTextLabel.m
//  voice
//
//  Created by Alexandre barbier on 17/12/13.
//  Copyright (c) 2013 Alexandre barbier. All rights reserved.
//

#import "TransparentTextLabel.h"
@interface TransparentTextLabel ()

@end
@implementation TransparentTextLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    // we have to override the background color to add alpha component because if alpha = 1.0 the compiler set the view opaque
    [super setBackgroundColor:[backgroundColor colorWithAlphaComponent:.99]];

}

- (void)drawTextInRect:(CGRect)rect {
    // get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    // set the text color transparent
    self.textColor = [UIColor clearColor];
    // set the blend mode to copy in order to copy the superview background
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    // set text inset if needed
    UIEdgeInsets insets = {0, 0, 0, 0};
    if (self.textInset.left) {
        insets = self.textInset;
    }
    // draw text
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}


@end
