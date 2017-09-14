//
//  BonusQuestionViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "BonusQuestionViewController.h"
#import "BonusAnswerView.h"
#import "BonusPointsView.h"
#import "QuestionViewController.h"
#import "GainerPointsViewController.h"


@interface BonusQuestionViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bonusContainerView;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnBonus;
@property (weak, nonatomic) IBOutlet UIPageControl *pager;
@property (weak, nonatomic) IBOutlet UIImageView *answerImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDescribtion;

@property (nonatomic,strong) BonusAnswerView *bonusView;
@property (nonatomic,strong) BonusPointsView *bonusPointsView;

@property (weak, nonatomic) IBOutlet UIImageView *viewBackGround;


@property (weak, nonatomic) IBOutlet UILabel *lblYouFound;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerTitle;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;


@end

@implementation BonusQuestionViewController

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if (theTextField.tag == 0) {
        
        if ([theTextField.text length] >0) {
            [theTextField resignFirstResponder];
            
            UITextField *currentTextField = self.bonusView.items[1];
            
            
            [currentTextField becomeFirstResponder];
            
        }
    }
    else if (theTextField.tag == 1) {
        if ([theTextField.text length] >0){
            [theTextField resignFirstResponder];

            UITextField *currentTextField = self.bonusView.items[2];
            
            
            [currentTextField becomeFirstResponder];
            
        }
    }
    else if (theTextField.tag == 2) {
        
        if ([theTextField.text length] >0){
            [theTextField resignFirstResponder];
            UITextField *currentTextField = self.bonusView.items[3];
            
            
            [currentTextField becomeFirstResponder];
            
        }
    }
    else if (theTextField.tag == 3) {
        
        if ([theTextField.text length] >0){
            [theTextField resignFirstResponder];
            UITextField *currentTextField = self.bonusView.items[4];
            
            
            [currentTextField becomeFirstResponder];
            
        }
    }
    else if (theTextField.tag == 4) {
        
 
        NSString *currentAnswer = @"";
        for (UITextField *currentTextBox in self.bonusView.items) {
            
            currentAnswer = [NSString stringWithFormat:@"%@%@",currentAnswer,currentTextBox.text];
            
            self.currentScore = self.currentScore + 1;
            
            
        }
        

        
        if ([currentAnswer isEqualToString:self.bonusItem.answer]) {
            
            [self.view endEditing:YES];
            
            [self.bonusView removeFromSuperview];
            self.bonusView = nil;
            [self.bonusPointsView setHidden:NO];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                

                
                [self segueShowPoiints:self];
                
            });
            
            
        
            
        }
        else {
            
            [self showAlert:@"Incorrect Answer" message:@""];
            
            int i = 0;
            
            for (UITextField *currentTextBox in self.bonusView.items) {
                currentTextBox.text = @"";
                
                if (i == 0) {
                    [currentTextBox becomeFirstResponder];
                    
                }
            
                i++;
                
                
                
            }
            
        }
        
        
        

        
        
        return;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [self performSegueWithIdentifier:@"segueShowAgain" sender:self];
            
        });
        
    }
    
    else {
        if ([theTextField.text length] >0){
           // [theTextField resignFirstResponder];
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.destinationViewController isKindOfClass:[QuestionViewController class]])
    {
    
        QuestionViewController *tmpDestination = segue.destinationViewController;
        tmpDestination.isQuestion2 = 1;
        
    }
    else if([segue.destinationViewController isKindOfClass:[GainerPointsViewController class]]){
        
        GainerPointsViewController *tmpDestination = segue.destinationViewController;
        tmpDestination.scoredPoints =  self.currentScore;
        
        tmpDestination.currentPark = self.currentPark;
        
        tmpDestination.level = self.currentLevel;
        
        
    }
}

-(BonusAnswerView *)bonusView {
    
    if (!_bonusView) {
        
        _bonusView =   (BonusAnswerView *)[self.view getViewFromNibName:@"BonusAnswerView"
                                                              withWidth:self.view.frame.size.width-20
                                                     withHeight:215];
        
        
        [self.view addSubview:_bonusView];
        
        _bonusView.center = self.view.center;
        [_bonusView setFrame:CGRectMake(_bonusView.frame.origin.x, _bonusView.frame.origin.y-75, _bonusView.frame.size.width, _bonusView.frame.size.height)];
        
        
        
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _bonusView;
    
}

-(BonusPointsView *)bonusPointsView {
    
    if (!_bonusPointsView) {
        
        _bonusPointsView =   (BonusPointsView *)[self.view getViewFromNibName:@"BonusPointsView"
                                                              withWidth:self.view.frame.size.width-20
                                                             withHeight:215];
        
        
        [self.view addSubview:_bonusPointsView];
        
        _bonusPointsView.center = self.view.center;
        [_bonusPointsView setFrame:CGRectMake(_bonusPointsView.frame.origin.x, _bonusPointsView.frame.origin.y-75, _bonusPointsView.frame.size.width, _bonusPointsView.frame.size.height)];
        
        
        [_bonusPointsView setUpView];
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _bonusPointsView;
    
}


- (void)drawDashedBorderAroundView:(UIView *)v
{
    //border definitions
    CGFloat cornerRadius = 20;
    CGFloat borderWidth = 3;
    NSInteger dashPattern1 = 8;
    NSInteger dashPattern2 = 8;
    UIColor *lineColor = [UIColor whiteColor];
    
    //drawing
    CGRect frame = v.bounds;
    
    CAShapeLayer *_shapeLayer = [CAShapeLayer layer];
    
    //creating a path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //drawing a border around a view
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    //path is set as the _shapeLayer object's path
    _shapeLayer.path = path;
    CGPathRelease(path);
    
    _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapeLayer.frame = frame;
    _shapeLayer.masksToBounds = NO;
    [_shapeLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.strokeColor = [lineColor CGColor];
    _shapeLayer.lineWidth = borderWidth;
    _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:dashPattern1], [NSNumber numberWithInt:dashPattern2], nil];
    _shapeLayer.lineCap = kCALineCapRound;
    
    //_shapeLayer is added as a sublayer of the view, the border is visible
    [v.layer addSublayer:_shapeLayer];
    v.layer.cornerRadius = cornerRadius;
}


-(void)swiperight{
    
    
    if (self.pager.currentPage == 1) {
        
    }
    else {
        [self.answerImage setHidden:YES];
        
        
        [self.lblDescribtion setHidden:NO];
        
        
        self.pager.currentPage = 1;
        
    }

}


-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (self.skipping) {
     
        [self segueShowPoiints:self];
        
        return;
        
    }
    else {
        
        [self.answerImage setHidden:NO];
        [self.lblAnswerTitle setHidden:NO];
     //   [self.lblDescribtion setHidden:NO];
    }
    [self.bonusView setHidden:YES];
   
    
    
    
    

    
 //   ;
    
        UIImage *fistImage = self.answerImage.image;
    
    
    
    [self.answerImage setImage:[self imageWithImage:fistImage scaledToWidth:self.answerImage.frame.size.width]];
    
    NSLog(@"");
    
}








-(void)swipeLeft{

    if (self.pager.currentPage == 0) {
        
    }
    else
    {

        self.pager.currentPage = 0;
        
        [self.answerImage setHidden:NO];
        
        
        [self.lblDescribtion setHidden:YES];
    }

    
    
}


- (IBAction)btnNextTapped:(id)sender {
    
    
    if (self.isQuestion2) {
    ///    [self performSegueWithIdentifier:@"segueShowPoints" sender:self];
    
        
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    for (UIButton *currentButton in self.allButtons) {
        
        
        [currentButton.titleLabel setFont:QuestionViewBottomButtonFonts];
        
    }
    self.lblYouFound.font = AnswerYouFoundFont;
    self.lblYouFound.textColor = AnswerFontColor;
    
    self.lblAnswerTitle.font = AnswerTitleFont;
    self.lblAnswerTitle.textColor = AnswerFontColor;
    
   // self.lblAnswerTitle.text = self.questionDoingOn;
    self.lblDescribtion.font = AnswerDescriptionFont;
    
    [self.navigationItem setHidesBackButton:YES];
    
    self.lblDescribtion.text = self.questionDoingOn.expDesc;
    

        [self addTopBarButtonByCode];
    
    
    [FileManager loadProfileImage:self.answerImage url:self.questionDoingOn.successImageUrl];
    
    
    [FileManager loadProfileImage:self.viewBackGround url:self.questionDoingOn.imageURL];;

    
    

    
    
    
    
    
    if (self.questionDoingOn.bonusId == 0)
    {
        [self.bonusContainerView setHidden:YES];
        
    }
    
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight)];
    swiperight.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swiperight];
    
    
    UISwipeGestureRecognizer * swipe2=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipe2.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe2];
    
    self.bonusContainerView.backgroundColor = [UIColor clearColor];
    [self drawDashedBorderAroundView:self.bonusContainerView];
    self.btnNext.layer.cornerRadius = 15;
    
    self.btnNext.titleLabel.font = QuestionViewBottomButtonFonts;
    
    
    if (IS_IPHONE_5 || IS_IPad) {
        
        self.btnNext.titleLabel.font = [UIFont fontWithName:self.btnNext.titleLabel.font.fontName size:self.btnNext.titleLabel.font.pointSize-3];
        
        
    }
    else {
        
    }
    
    self.btnBonus.layer.cornerRadius = 15;
    
    
    if (self.isQuestion2) {
        
        [self.answerImage setImage:[UIImage imageNamed:@"compassplant-yellow"]];
        
    
        [self.bonusContainerView setHidden:YES];
        
    }
    else {
    
        
        
        
        
    }
    
    self.lblAnswerTitle.text = self.questionDoingOn.expTitle.uppercaseString;
    
    
}

- (IBAction)btnBonusTapped {
    
    [self.bonusView setHidden:NO];
    
    
    [_bonusView setupView];
    
    NSArray *textViews = _bonusView.items;
    
    int i =0;
    
    
    _bonusView.lblBonusQuestion.text = self.bonusItem.question;
    
    for (UITextField *currentTextField in textViews)
    {
        
        currentTextField.delegate = self;
        
        [currentTextField addTarget:self action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
        
        if (i == 0) {
            
            
        }
        
    }
    
}
- (IBAction)segueShowPoiints:(id)sender {
 
    if (self.isThingLastQuestion)
    {
        
        
        [self performSegueWithIdentifier:@"segueShowPoints" sender:self];
        
        
        return;
        
    }
    
    
    [self showLoader];
    
    [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].imageURL
                          withLoader:nil
               withComplitionHandler:^(id c) {
                   
                   [self hideLoader];
                   
                   [self.questionViewController setupViewNextQuestion];
                   
                   
                   CATransition *transition = [CATransition animation];
                   transition.duration = 0.5;
                   transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                   transition.type = kCATransitionPush;
                   transition.subtype = kCATransitionFromRight;
                   //[self.view.window.layer addAnimation:transition forKey:nil];
                   
                   
                   [self.navigationController.view.layer addAnimation:transition forKey:nil];
                   [[self navigationController] popViewControllerAnimated:NO];
    
                   
                   
               } withFailHander:^(int d) {
                   
                   [self hideLoader];
                   
                   [self.questionViewController setupViewNextQuestion];
                   
                   
                   CATransition *transition = [CATransition animation];
                   transition.duration = 0.5;
                   transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                   transition.type = kCATransitionPush;
                   transition.subtype = kCATransitionFromRight;
                   //[self.view.window.layer addAnimation:transition forKey:nil];
                   
                   
                   [self.navigationController.view.layer addAnimation:transition forKey:nil];
                   [[self navigationController] popViewControllerAnimated:NO];
    
                   
                   
                   
               }];
    
    
    
    


}

@end
