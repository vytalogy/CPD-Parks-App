//
//  SelectQuizTypeViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "SelectQuizTypeViewController.h"
#import "InGameScoreView.h"
#import "QuestionViewController.h"
#import "FileManager.h"
#import "RulesView.h"
#import "Rules.h"
#import "HintView.h"


@interface SelectQuizTypeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIView *viewContainerTypeOne;
@property (weak, nonatomic) IBOutlet UIView *viewContainerTypeTwo;

@property (weak, nonatomic) IBOutlet UILabel *lblTypeOne;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeTwo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLevel1DistanceFromLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLevel2DistanceFromLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceFromTop;
@property (nonatomic,strong) NSArray<Level *> *allLevels;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

@property (nonatomic) int levelSelected;

@property (nonatomic,strong) NSMutableArray *questionToSendForPlaying;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *levelLabels;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcomeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpacing;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionLeftSpacing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionRightSpacing;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *juniorSpacing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proSpacing;

@property (nonatomic,strong) RulesView * rulesViews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleAndExplainationGap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TitleContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *welcomeContstant;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic,strong) HintView *hintView;

@property (nonatomic,strong) CAShapeLayer *secondLayer;

@end

@implementation SelectQuizTypeViewController

-(void)closeRulesView{
    
    [self.rulesViews setHidden:YES];
    
}


-(void)getStarted{
    
    [self showLoader];
    
    
    
    
    
    [Question callQuestionsFromLevelId:self.allLevels[self.levelSelected].itemId
                            withParkId:self.selectedPark.itemId
                     ComplitionHandler:^(id result) {
                         
                         
                         
                         self.questionToSendForPlaying = result;
                         
                         Question *firstItem = result[0];
                         
                         
                         
                         
                         [FileManager loadProfileImageUrl:firstItem.imageURL
                                               withLoader:nil
                                    withComplitionHandler:^(id check) {
                                        
                                        [self hideLoader];
                                        
                                        [self performSegueWithIdentifier:@"segueShowQuestion" sender:self];
                                        
                                        self.sharedDelegate.isPlayingGame = YES;
                                        
                                        
                                    } withFailHander:^(int f) {
                                        
                                        [self performSegueWithIdentifier:@"segueShowQuestion" sender:self];
                                        
                                        
                                    }];
                         
                         
                         [FileManager loadProfileImageUrl:firstItem.successImageUrl
                                               withLoader:nil
                                    withComplitionHandler:^(id check) {
                                        
                                        
                                    } withFailHander:^(int f) {
                                        
                                        
                                        
                                    }];
                         
                         
                         
                         
                         
                         
                         
                     } withFailueHandler:^{
                         
                     }];
    
    
    
}

-(RulesView *)rulesViews {
    
    if (!_rulesViews) {
        
        _rulesViews =   (RulesView *)[self.view getViewFromNibName:@"RulesViewWithButton"
                                                         withWidth:self.view.frame.size.width
                                                        withHeight:self.view.frame.size.height];
        
        
                [_rulesViews setUpView];
        
        
        
        [_rulesViews.btnClose addTarget:self action:@selector(closeRulesView) forControlEvents:UIControlEventTouchUpInside];
        
        [_rulesViews.btnGetStarted addTarget:self action:@selector(getStarted) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        [Rules callRulesWithComplitionHandler:^(id result) {
            
            
            result = [result stringByReplacingOccurrencesOfString:_rulesViews.lblTitle.text withString:@""];
            
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

-(void)typeOneTapped{
    [self.rulesViews setHidden:NO];
    
    
    self.levelSelected = 0;
    
    

    return;
    
    
    


}

-(void)typeTwoTapped{
    
    
    [self.rulesViews setHidden:NO];
    
    self.levelSelected = 1;
    
    
    return;
    
    
    [self showLoader];
    

    [Question callQuestionsFromLevelId:self.allLevels[self.levelSelected].itemId
                            withParkId:self.selectedPark.itemId
                     ComplitionHandler:^(id result) {
                         
                                                  [self hideLoader];
                         
                         
                         self.questionToSendForPlaying = result;
                         
                         
                         
                         [self performSegueWithIdentifier:@"segueShowQuestion" sender:self];
                         
                         self.sharedDelegate.isPlayingGame = YES;
                         
                     } withFailueHandler:^{
                         
                     }];

    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"segueShowQuestion"])
    {
        QuestionViewController *desination = segue.destinationViewController;
        
        desination.levelSelected = self.allLevels[self.levelSelected];
        desination.parkSelected = self.selectedPark;
        desination.startingQuiz = YES;
        desination.allQuestion = self.questionToSendForPlaying;
        
        
    }
}

-(void)hintCloseButtonTapped{
    
    
    self.hintView.hidden = YES;
    
    [self.hintView removeFromSuperview];
    
    [self.lblTitle setHidden:NO];
    
    [self.lblDetail setHidden:NO];
    [self.lblWelcomeLabel setHidden:NO];
    [self.viewContainerTypeOne setHidden:NO];
    [self.viewContainerTypeTwo setHidden:NO];
 
    
    
    return;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    
    
    layer.path = path.CGPath;
    layer.fillColor = self.transperancyColor.CGColor;
    layer.strokeColor =  nil;
    [self.viewContainerTypeOne.layer insertSublayer:layer atIndex:0];
    
    
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path2 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path2 addLineToPoint:CGPointMake(_viewContainerTypeTwo.frame.size.width, 0)]; // top right corner-
    [path2 addLineToPoint:CGPointMake(_viewContainerTypeTwo.frame.size.width, 63)]; // bottom right corner
    [path2 closePath];
    
    layer2.path = path2.CGPath;
    layer2.fillColor = self.transperancyColor.CGColor;
    layer2.strokeColor =  nil;
    [self.viewContainerTypeTwo.layer insertSublayer:layer2 atIndex:0];
    
    
    
    self.secondLayer =layer2;
    
    //[self.viewContainerTypeTwo setBackgroundColor:[UIColor greenColor]];
    
}

-(HintView *)hintView {
    
    if (!_hintView) {
        
        _hintView =   (HintView *)[self.view getViewFromNibName:@"HintView2" withWidth:self.view.frame.size.width
                                                     withHeight:self.view.frame.size.height];
        [_hintView setupView];
        
        [self.view addSubview:_hintView];
        

        
        
        [_hintView.btnCross addTarget:self action:@selector(hintCloseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        _hintView.lblDetail.text = @"This ReQuest starts at the parking lot on 122nd St on the south side of Indian Ridge Marsh. If you’re at the lot on Torrence Ave, you’re in the wrong spot! We’ll move here later in the quest.";
        
        [_hintView.lblHint setHidden:YES];
        _hintView.HintHeight.constant = 20;
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _hintView;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    
    
 
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    
    for (UILabel * allLabels in self.levelLabels) {
        
        [allLabels setFont:ParkAndLevelFont];
        allLabels.textColor = ParkAndLevelFontColor;
        
    }
   
  //  [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];

    
    
    
    
    self.lblWelcomeLabel.font = SelectLevelWelcomeToFont;
    self.lblTitle.font = SelectLevelNameFont;
    self.lblDetail.font = SelectLevelTextFont;
    //

    
    if (IS_IPHONE_6P) {
        
        self.viewLevel1DistanceFromLeft.constant = self.viewLevel1DistanceFromLeft.constant +10;
        self.viewLevel2DistanceFromLeft.constant = self.viewLevel2DistanceFromLeft.constant + 10;
        
    }
    else
    if (IS_IPHONE_6) {
        
        //self.bottomSpacing.constant = self.bottomSpacing.constant-20;
        
        //self.distanceFromTop.constant = self.distanceFromTop.constant - 35;
        
        self.lblDetail.font = [UIFont fontWithName:self.lblDetail.font.fontName size:self.lblDetail.font.pointSize -2];
        
    }
    else if(IS_IPHONE_5 || IS_IPOD){
      
        
        self.topSpace.constant = 8;
        self.descriptionLeftSpacing.constant = 5;
        self.descriptionRightSpacing.constant = 5;
        
        self.lblTitle.font =  [UIFont fontWithName:self.lblTitle.font.fontName size:self.lblTitle.font.pointSize-6];;
        self.lblDetail.font =  [UIFont fontWithName:self.lblDetail.font.fontName size:self.lblDetail.font.pointSize-3];;
        self.lblWelcomeLabel.font =  [UIFont fontWithName:self.lblWelcomeLabel.font.fontName size:self.lblWelcomeLabel.font.pointSize-6];;
        
        self.titleAndExplainationGap.constant = 8;
        
        self.bottomSpacing.constant = self.bottomSpacing.constant-20;
        self.juniorSpacing.constant = self.juniorSpacing.constant-20;
        self.proSpacing.constant = self.proSpacing.constant - 20;
        self.TitleContraint.constant = 35;
        self.welcomeContstant.constant = 20;
        
        
    }
    else if(IS_IPad){
        
        self.topSpace.constant = 5;
        
        self.descriptionLeftSpacing.constant = 5;
        
        self.descriptionRightSpacing.constant = 5;
        
        
        
        
        self.lblTitle.font =  [UIFont fontWithName:self.lblTitle.font.fontName size:self.lblTitle.font.pointSize-7];;
        
        
        self.lblDetail.font =  [UIFont fontWithName:self.lblDetail.font.fontName size:self.lblDetail.font.pointSize-7];;
        
        
        self.bottomSpacing.constant = self.bottomSpacing.constant-40;
        
        
        self.juniorSpacing.constant = self.juniorSpacing.constant-20;
        self.proSpacing.constant = self.proSpacing.constant - 20;
        
        
    }
    
    [self.navigationItem setHidesBackButton:YES];
    
    
    [self addTopBarButtonByCode];
 
    
    
    [self showLoader];
    [Level callGetAllLevelComplitionHandler:^(id result)
    {
        
        [self hideLoader];
        
        self.allLevels = result;
        
        
        
        self.lblTypeOne.text = self.allLevels[0].levelName;
        self.lblTypeTwo.text = self.allLevels[1].levelName;
        
      
        
        NSLog(@"");
        
    }
    withFailueHandler:^{
        
    }];
    
    self.lblTitle.text = self.selectedPark.parkName;
    
    self.lblDetail.text = self.selectedPark.parkDescription;

    
    self.viewContainerTypeOne.backgroundColor = [UIColor clearColor];
    self.viewContainerTypeTwo.backgroundColor = [UIColor clearColor];
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeTwoTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.lblTypeTwo addGestureRecognizer:tapGestureRecognizer];
    self.lblTypeTwo.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeOneTapped)];
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    [self.lblTypeOne addGestureRecognizer:tapGestureRecognizer2];
    self.lblTypeOne.userInteractionEnabled = YES;
    
    

    
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
/*    if (self.selectedPark.itemId == 3) {
        
        return;
    }*/
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    
    
    layer.path = path.CGPath;
    layer.fillColor = self.transperancyColor.CGColor;
    layer.strokeColor =  nil;
    [self.viewContainerTypeOne.layer insertSublayer:layer atIndex:0];
    
    
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path2 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path2 addLineToPoint:CGPointMake(_viewContainerTypeTwo.frame.size.width, 0)]; // top right corner-
    [path2 addLineToPoint:CGPointMake(_viewContainerTypeTwo.frame.size.width, 63)]; // bottom right corner
    [path2 closePath];
    
    layer2.path = path2.CGPath;
    layer2.fillColor = self.transperancyColor.CGColor;
    layer2.strokeColor =  nil;
    [self.viewContainerTypeTwo.layer insertSublayer:layer2 atIndex:0];
    
    
    
    self.secondLayer =layer2;
    
    
    if (self.selectedPark.itemId == 3) {

        [self.hintView setHidden:NO];
    }
    
    
    
    //
}



@end
