//
//  MenuViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MenuViewController.h"
#import "MapView.h"
#import "Rules.h"
#import "RulesView.h"
#import "WarningLeaving.h"

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


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *AllLabels;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerRules;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerWebsite;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerMap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerYourProfile;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerMainMenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceFromTopButton;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeButtonDistanceFromTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeButtonWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainMenuContainerHeight;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundGreenView;

@property (nonatomic,strong) MapView * mapView;

@property (nonatomic,strong) RulesView * rulesViews;

@property (nonatomic,strong) WarningLeaving *warningView;

@property (nonatomic) NSString *bigMapUrl;
@property (nonatomic) NSString *indianMapUrl;
@property (nonatomic) NSString *hegwishMapUrl;


@property (nonatomic) AppDelegate *sharedDelegate;

@property (nonatomic) int warningScenario;

@end

@implementation MenuViewController

-(void)closeRulesView{
    
    [self.rulesViews setHidden:YES];
    [self.mapView setHidden:YES];

}

-(void)cancelWarningView{
    
    
    [self.warningView setHidden:YES];
    [self.view bringSubviewToFront:self.warningView];
    
}

-(void)warningExitTapped{
    
    if (self.warningScenario == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate mainMenuButtonTapped];
            
            self.sharedDelegate.isPlayingGame = NO;
        }];
    }
    else if (self.warningScenario == 2){
     
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate profileButtonTapped];

            self.sharedDelegate.isPlayingGame = NO;
            
        }];

        
    }

    
    
}
-(WarningLeaving *)warningView {
    
    if (!_warningView) {
        
        _warningView =   (WarningLeaving *)[self.view getViewFromNibName:@"WarningLeaving"
                                                         withWidth:self.view.frame.size.width
                                                        withHeight:self.view.frame.size.height];
        
        
        
        
        [_warningView.btnCancel addTarget:self action:@selector(cancelWarningView) forControlEvents:UIControlEventTouchUpInside];
        
        [_warningView.btnExit addTarget:self action:@selector(warningExitTapped) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_warningView setupView];
        [self.view addSubview:_warningView];
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _warningView;
    
    
}


-(RulesView *)rulesViews {
    
    if (!_rulesViews) {
        
        _rulesViews =   (RulesView *)[self.view getViewFromNibName:@"RulesView"
                                                         withWidth:self.view.frame.size.width
                                                        withHeight:self.view.frame.size.height];
        
        
        
        
        [_rulesViews.btnClose addTarget:self action:@selector(closeRulesView) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //_rulesViews.center = self.view.center;
        
        
        
        
        
        [_rulesViews setUpView];
        
        _rulesViews.lblRules.text = @"";
        
        
        [Rules callRulesWithComplitionHandler:^(id result) {
            
            
            result = [result stringByReplacingOccurrencesOfString:_rulesViews.lblTitle.text withString:@""];
            
            result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
            
            
            _rulesViews.lblRules.text = result;
        
            
            
        } withFailueHandler:^{
            
        }];
        
        
        
        
        [self.view addSubview:_rulesViews];
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _rulesViews;
    
    
}

-(void)closeMapView{
    
    
    [self.mapView setHidden:YES];
    [self.backgroundGreenView setHidden:YES];
    
}
-(MapView *)mapView {
    
    if (!_mapView) {
        
        _mapView =   (MapView *)[self.view getViewFromNibName:@"MapView"
                                                    withWidth:self.view.frame.size.width
                                                   withHeight:self.view.frame.size.height];
        
        
        
        
        [_mapView.btnExit addTarget:self action:@selector(closeMapView) forControlEvents:UIControlEventTouchUpInside];
        [_mapView.btnClose addTarget:self action:@selector(closeMapView) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        _mapView.center = self.view.center;
        
        
        
        [_mapView setUpView];
        
        
        
        [self.view addSubview:_mapView];
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _mapView;
    
    
}


- (IBAction)dismissViewController:(id)sender {
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    
}



-(void)mainMenuButtonTapped{
    
    
    if (self.sharedDelegate.isPlayingGame) {
        
        [self.warningView setHidden:NO];
        
        [self.view bringSubviewToFront:self.warningView];
        
        self.warningScenario = 1;
        
        
    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate mainMenuButtonTapped];
            
        }];
    
        
        
    }
    
    
    
    
    
}
-(void)yourProfileButtonTapped{
    
    if (self.sharedDelegate.isPlayingGame) {
        
        [self.warningView setHidden:NO];
        
        self.warningScenario = 2;
        
        [self.view bringSubviewToFront:self.warningView];
        
        
    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate profileButtonTapped];
            
        }];

        
    }
    
    
 
    
}

-(AppDelegate *)sharedDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(void)showWebSiteButtonTapped{
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.chicagosesideparks.com/"]];
    
    return;
    
    
    
    
    return;
    
    return;
    [self.backgroundGreenView setHidden:NO];
    [self.view bringSubviewToFront:self.backgroundGreenView];
    [self.mapView setHidden:NO];
    [self.view bringSubviewToFront:self.mapView];
    
}

-(void)rulesButtonTapped{
    
    
    [self.rulesViews setHidden:NO];
    
    [self.view bringSubviewToFront:self.rulesViews];
    
    return;
    [self.backgroundGreenView setHidden:NO];
    [self.view bringSubviewToFront:self.backgroundGreenView];
    [self.mapView setHidden:NO];
    [self.view bringSubviewToFront:self.mapView];
    
}

-(void)mapButtonTapped{
    
    //
    
    [self.delegate mapButtonTapped];
    
    return;
    [self.backgroundGreenView setHidden:NO];
    [self.view bringSubviewToFront:self.backgroundGreenView];
    [self.mapView setHidden:NO];
    [self.view bringSubviewToFront:self.mapView];
    
}

-(NSString *)hegwishMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.655496,%%20-87.564370&zoom=15&size=640x640"];
    
    
}

-(NSString *)bigMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.690329,-87.5705071&zoom=15&size=640x640"];
    
    
}

-(NSString *)indianMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.6800257,-87.5606165&zoom=15&size=640x640"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *currentDefault = [NSUserDefaults standardUserDefaults];
    
    if ([currentDefault objectForKey:@"hasitBeenDone"]) {
        
        [FileManager loadProfileImage:nil url:self.hegwishMapUrl];
        [FileManager loadProfileImage:nil url:self.hegwishMapUrl];
        [FileManager loadProfileImage:nil url:self.indianMapUrl];
        
        [currentDefault setObject:@"1" forKey:@"hasitBeenDone"];
        
        
        
    }
    

    
    
    
    
[self.navigationController setNavigationBarHidden:YES animated:NO];
    

    NSLog(@"%@",self.lblMap.font.fontName);
    
    
    
    
    if (IS_IPHONE_6) {
        
        self.containerMainMenu.constant = self.containerMainMenu.constant+6;
        
        self.containerMap.constant = self.containerMap.constant-6;
        self.containerWebsite.constant = self.containerWebsite.constant-10;
        
    self.containerRules.constant = self.containerRules.constant-15;
        
    }
    else if(IS_IPHONE_5){
        
        self.bottomSpaceFromTopButton.constant = 10;
        
        self.containerMainMenu.constant = self.containerMainMenu.constant-6;
        self.containerYourProfile.constant = self.containerYourProfile.constant-19;
        
        self.containerMap.constant = self.containerMap.constant-28;
        
        self.containerWebsite.constant = self.containerWebsite.constant-40;
       
        
        self.containerRules.constant = self.containerRules.constant-50;
        
        
    }
    
    else if(IS_IPad){
        
        self.bottomSpaceFromTopButton.constant = 0
        ;
        
        self.containerMainMenu.constant = self.containerMainMenu.constant-6;
        self.containerYourProfile.constant = self.containerYourProfile.constant-19;
        
        self.containerMap.constant = self.containerMap.constant-28;
        
        self.containerWebsite.constant = self.containerWebsite.constant-40;
        
        
        self.containerRules.constant = self.containerRules.constant-50;
        
        self.closeButtonDistanceFromTop.constant = 0;
        
        
       // self.stackView.distribution = UIStackViewDistributionFill;
        
        
        self.closeButtonHeight.constant = 25;
        self.closeButtonWidth.constant = 25;
        
        
        self.mainMenuContainerHeight.constant = 40;
        
        
    }
    for (UILabel *currentLabel in self.AllLabels) {
        
        [currentLabel setFont:[UIFont fontWithName:FontToUserMedium size:31]];
     
        
        currentLabel.textColor = [UIColor blackColor];;
        
        
    }
    
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
    
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapButtonTapped)];
    
    tapGestureRecognizer3.numberOfTapsRequired = 1;
    
    [self.viewContainerThree addGestureRecognizer:tapGestureRecognizer3];
    
    self.viewContainerThree.userInteractionEnabled = YES;
    
    
    //
    
    [self.viewContainerFour setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWebSiteButtonTapped)];
    tapGestureRecognizer4.numberOfTapsRequired = 1;
    [self.viewContainerFour addGestureRecognizer:tapGestureRecognizer4];
    self.viewContainerFour.userInteractionEnabled = YES;
    
    
    
    //
    
    UITapGestureRecognizer *tapGestureRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rulesButtonTapped)];
    tapGestureRecognizer5.numberOfTapsRequired = 1;
    [self.viewContainerFive addGestureRecognizer:tapGestureRecognizer5];
    self.viewContainerFive.userInteractionEnabled = YES;
    
    
    
}
-(UIColor *)transperancyColor{
    
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    
    
    layer.fillColor = self.transperancyColor.CGColor;
    //  layer.fillColor = self.transperancyColor.CGColor;
    
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
    layer2.fillColor = self.transperancyColor.CGColor;
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
    layer3.fillColor = self.transperancyColor.CGColor;
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
    layer4.fillColor = self.transperancyColor.CGColor;
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
    layer5.fillColor = self.transperancyColor.CGColor;
    layer5.strokeColor =  nil;
    [self.viewContainerFive.layer insertSublayer:layer5 atIndex:0];
    
    

    
}
-(void)viewDidLayoutSubviews{
    
    
    [super viewDidLayoutSubviews];
    
    return;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(_viewContainerOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    
    
    layer.fillColor = self.transperancyColor.CGColor;
  //  layer.fillColor = self.transperancyColor.CGColor;
    
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
    layer2.fillColor = self.transperancyColor.CGColor;
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
    layer3.fillColor = self.transperancyColor.CGColor;
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
    layer4.fillColor = self.transperancyColor.CGColor;
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
    layer5.fillColor = self.transperancyColor.CGColor;
    layer5.strokeColor =  nil;
    [self.viewContainerFive.layer insertSublayer:layer5 atIndex:0];
    
    
    
    
    
    //
}

@end
