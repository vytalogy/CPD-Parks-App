//
//  InGameScoreView.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "InGameScoreView.h"

@implementation InGameScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setUpView{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 50)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(self.frame.size.width, 50)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    layer.fillColor = self.backgroundColor.CGColor;
    layer.strokeColor =  nil;
    [self.layer insertSublayer:layer atIndex:0];
    

    
    self.backgroundColor = [UIColor clearColor];
    
    
}
@end
