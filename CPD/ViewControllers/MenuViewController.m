//
//  MenuViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewContainerOne;
@property (weak, nonatomic) IBOutlet UIView *viewContainerTwo;
@property (weak, nonatomic) IBOutlet UIView *viewContainerThree;
@property (weak, nonatomic) IBOutlet UIView *viewContainerFour;
@property (weak, nonatomic) IBOutlet UIView *viewContainerFive;


@property (weak, nonatomic) IBOutlet UILabel *lblMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblYourProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblMap;

@property (weak, nonatomic) IBOutlet UILabel *lblRules;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;




@end

@implementation MenuViewController
- (IBAction)dismissViewController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}



-(void)mainMenuButtonTapped{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate mainMenuButtonTapped];
    
    }];
    
    
    
}
-(void)yourProfileButtonTapped{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate profileButtonTapped];
        
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    [self.viewContainerFive setBackgroundColor:[UIColor clearColor]];
    [self.viewContainerOne setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainMenuButtonTapped)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.viewContainerOne addGestureRecognizer:tapGestureRecognizer];
    
    self.viewContainerOne.userInteractionEnabled = YES;
    
    
    [self.viewContainerTwo setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourProfileButtonTapped)];
    
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    
    [self.viewContainerTwo addGestureRecognizer:tapGestureRecognizer2];
    
    self.viewContainerTwo.userInteractionEnabled = YES;
    
    
    [self.viewContainerThree setBackgroundColor:[UIColor clearColor]];
    
    [self.viewContainerFour setBackgroundColor:[UIColor clearColor]];
    
}


-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer.strokeColor =  nil;
    [self.viewContainerOne.layer insertSublayer:layer atIndex:0];
    
    
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path2 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path2 addLineToPoint:CGPointMake(_viewContainerTwo.frame.size.width, 0)]; // top right corner-
    [path2 addLineToPoint:CGPointMake(_viewContainerTwo.frame.size.width, 63)]; // bottom right corner
    [path2 closePath];
    
    layer2.path = path2.CGPath;
    layer2.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer2.strokeColor =  nil;
    [self.viewContainerTwo.layer insertSublayer:layer2 atIndex:0];
    
    
    
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path3 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path3 addLineToPoint:CGPointMake(_viewContainerThree.frame.size.width, 0)]; // top right corner-
    [path3 addLineToPoint:CGPointMake(_viewContainerThree.frame.size.width, 63)]; // bottom right corner
    [path3 closePath];
    
    layer3.path = path3.CGPath;
    layer3.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer3.strokeColor =  nil;
    [self.viewContainerThree.layer insertSublayer:layer3 atIndex:0];
    

    CAShapeLayer *layer4 = [CAShapeLayer layer];
    
    UIBezierPath * path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path4 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path4 addLineToPoint:CGPointMake(_viewContainerFour.frame.size.width, 0)]; // top right corner-
    [path4 addLineToPoint:CGPointMake(_viewContainerFour.frame.size.width, 63)]; // bottom right corner
    [path4 closePath];
    
    layer4.path = path4.CGPath;
    layer4.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer4.strokeColor =  nil;
    [self.viewContainerFour.layer insertSublayer:layer4 atIndex:0];
    
    
    
    CAShapeLayer *layer5 = [CAShapeLayer layer];
    
    UIBezierPath * path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path5 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path5 addLineToPoint:CGPointMake(_viewContainerFive.frame.size.width, 0)]; // top right corner-
    [path5 addLineToPoint:CGPointMake(_viewContainerFive.frame.size.width, 63)]; // bottom right corner
    [path5 closePath];
    
    layer5.path = path5.CGPath;
    layer5.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer5.strokeColor =  nil;
    [self.viewContainerFive.layer insertSublayer:layer5 atIndex:0];
    
    
    
    
    
    //
}

@end
