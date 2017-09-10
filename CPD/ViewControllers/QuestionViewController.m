//
//  QuestionViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "QuestionViewController.h"
#import "AppDelegate.h"
#import "InGameScoreView.h"
#import "QuestionView.h"
#import "HintView.h"
#import "BonusQuestionViewController.h"
#import "QuestionScoreView.h"
#import "RulesView.h"
#import "UIView+RevealAnimation.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UIView *scoreContainer;
@property (nonatomic,strong) InGameScoreView * gameScoreView;

@property (nonatomic,strong) QuestionView *questionView;

@property (nonatomic,strong) HintView *hintView;


@property (nonatomic,strong) QuestionScoreView *questionScoreView;

@property (weak, nonatomic) IBOutlet UIButton *btnFoundIT;
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@property (weak, nonatomic) IBOutlet UIButton *btnHint;

@property (weak, nonatomic) IBOutlet UIView *viewQuestionContainer;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (nonatomic,strong) UIView *otherContainerView;

@property (nonatomic) int scoredPoints;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bottomButtons;

@property (nonatomic,strong) RulesView * rulesViews;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QuestionContainerConstant;

@property (nonatomic) BOOL skipping;


@property (nonatomic) int scoreToBeAdded;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHintConstant;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnFountItConstant;



@end

@implementation QuestionViewController


-(void)closeRulesView{
    
    [self.rulesViews setHidden:YES];
    
}
-(RulesView *)rulesViews {
    
    if (!_rulesViews) {
        
        _rulesViews =   (RulesView *)[self.view getViewFromNibName:@"RulesView"
                                                    withWidth:self.view.frame.size.width
                                                   withHeight:self.view.frame.size.height];
        
        
        
        
        [_rulesViews.btnClose addTarget:self action:@selector(closeRulesView) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //_rulesViews.center = self.view.center;
        
        
    
        
        
        [_rulesViews setUpView];
        
    
        
        [self.view addSubview:_rulesViews];
        
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _rulesViews;
    
    
}


-(void)setupViewNextQuestion{
    
    [self.otherContainerView removeFromSuperview];
    self.otherContainerView = nil;
    
    [_questionView removeFromSuperview];
    
    _questionView = nil;
    
    self.startingQuiz = NO;
    self.questionIndex = self.questionIndex +1;
    
    
    [self.btnHint setHidden:NO];
    [self.btnSkip setHidden:NO];
    [self.btnFoundIT setHidden:NO];
    
    [self.viewQuestionContainer setHidden:NO];
    [self.scoreContainer setHidden:NO];
    
    
    
    [self.questionView setHidden:NO];
    
    _hintView.lblDetail.text = self.allQuestion[self.questionIndex].hint;
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[BonusQuestionViewController class]]) {
        
            BonusQuestionViewController *tmpDestination = segue.destinationViewController;
        //    tmpDestination.isQuestion2 = true;
        
        if (self.skipping) {
            
            self.skipping = NO;
            tmpDestination.skipping = YES;
            
        }
        tmpDestination.questionDoingOn = self.allQuestion[self.questionIndex];
        _hintView.lblDetail.text = self.allQuestion[self.questionIndex].hint;
        _questionView.lblQuestionText.text = self.allQuestion[self.questionIndex].question;
        
        
        tmpDestination.currentPark = self.parkSelected;
        

        
        tmpDestination.questionViewController = self;
        tmpDestination.currentLevel = self.levelSelected;
        
        
        if (self.questionIndex+1 == [self.allQuestion count]) {
            tmpDestination.isThingLastQuestion = YES;
            tmpDestination.currentScore = self.scoredPoints;
            
        }
        
        
        tmpDestination.questionIndex = self.questionIndex;
        tmpDestination.allQuestion = self.allQuestion;
        
        
        /*

         @property (nonatomic,strong) NSMutableArray <Question *>* allQuestion;
         */
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *bonusItemName = [NSString stringWithFormat:@"Bonus/%d/%d",self.parkSelected.itemId,self.levelSelected.itemId];
        
        
        id dataAraay = [userDefaults objectForKey:bonusItemName];
    
        
        

        
        if (dataAraay) {
            
            NSLog(@"");
            
            NSArray *items = [Bonus parseMyInvolvedChainsFrom:dataAraay];
            
            
            
            
            
            
            id answer = [items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.questionId == %d)", self.allQuestion[self.questionIndex].questionId]];
            
            
            if ([answer count] > 0) {
                
                tmpDestination.bonusItem = answer[0];
                
                
                NSLog(@"%@",answer);
                

            }
            
            
        }
    
        
        //isThingLastQuestion
            
            
        
    }
}
-(HintView *)hintView {
    
    if (!_hintView) {
        
        _hintView =   (HintView *)[self.view getViewFromNibName:@"HintView" withWidth:self.view.frame.size.width-30
                                                     withHeight:297];
        [_hintView setupView];
        
        [self.view addSubview:_hintView];
        
        _hintView.center = self.view.center;
        [_hintView setFrame:CGRectMake(_hintView.frame.origin.x, _hintView.frame.origin.y-75, _hintView.frame.size.width, _hintView.frame.size.height)];
        
        
        [_hintView.btnCross addTarget:self action:@selector(hintCloseButtonTapped) forControlEvents:UIControlEventTouchUpInside];
       
        _hintView.lblDetail.text = self.allQuestion[self.questionIndex].hint;
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _hintView;
    
}


-(QuestionScoreView *)questionScoreView {
    
    if (!_questionScoreView) {
        
        
        _questionScoreView =   (QuestionScoreView *)[self.view getViewFromNibName:@"QuestionScoreView"
                                                                        withWidth:self.view.frame.size.width
                                                     withHeight:self.view.frame.size.height];
       
        
        
        [FileManager loadProfileImage:_questionScoreView.backGround
                                  url:self.allQuestion[self.questionIndex].imageURL];

        [FileManager loadProfileImage:_questionScoreView.backGround
                                  url:self.allQuestion[self.questionIndex].successImageUrl];
        

        

        [self.view addSubview:_questionScoreView];
        

    }
    else {
        
        [FileManager loadProfileImage:_questionScoreView.backGround url:self.allQuestion[self.questionIndex].imageURL];

        
        [FileManager loadProfileImage:_questionScoreView.backGround url:self.allQuestion[self.questionIndex].successImageUrl];
        
        
        //_hintView.hidden = NO;
        
    }
    return _questionScoreView;
    
}
-(void)hintCloseButtonTapped{

    
    self.hintView.hidden = YES;
    
    
    
}


-(QuestionView *)questionView {
    
    if (!_questionView) {
        
        
        
        
        //_questionView =   (QuestionView *)[self.view
          //                                 getViewFromNibName:@"QuestionView"];
        
        
        
        
        _questionView =   (QuestionView *)[self.view
                                           getViewFromNibName:@"QuestionView"
                                           withWidth:self.viewQuestionContainer.frame.size.width
                                           withHeight:self.viewQuestionContainer.frame.size.height];
        
        _questionView.questionNumber = self.questionIndex + 1;
        

        [_questionView setUpView];
        

        [self.viewQuestionContainer setBackgroundColor:[UIColor clearColor]];
        [self.viewQuestionContainer addSubview:_questionView];
        
        //textView.adjustsFontSizeToFitWidth = YES;

        _questionView.lblQuestionText.adjustsFontSizeToFitWidth = YES;
        
        _questionView.lblQuestionText.text = self.allQuestion[self.questionIndex].question;
  //      [_questionView.lblQuestionText sizeToFit];
        
//        _questionView.lblQuestionText.backgroundColor = [UIColor yellowColor];
        


        
        
        
        NSLayoutConstraint *trailing =[NSLayoutConstraint
                                       constraintWithItem:_questionView
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_viewQuestionContainer
                                       attribute:NSLayoutAttributeTrailing
                                       multiplier:1.0f
                                       constant:0.f];

        
        NSLayoutConstraint *leading = [NSLayoutConstraint
                                       constraintWithItem:_questionView
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:_viewQuestionContainer
                                       attribute:NSLayoutAttributeLeading
                                       multiplier:1.0f
                                       constant:0.f];
        
        
        NSLayoutConstraint *bottom =[NSLayoutConstraint
                                    constraintWithItem:_questionView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:_viewQuestionContainer
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1.0f
                                    constant:0.f];
        
        
        
        NSLayoutConstraint *top =[NSLayoutConstraint
                                     constraintWithItem:_questionView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:_viewQuestionContainer
                                     attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                     constant:0.f];
        
        
        NSLayoutConstraint *height = [NSLayoutConstraint
                                      constraintWithItem:_questionView
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:0
                                      constant:120.f];
        
        
      
        
        
        [FileManager loadProfileImage:self.backgroundImage url:self.allQuestion[self.questionIndex].imageURL];;

        [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex].successImageUrl
                              withLoader:nil
                   withComplitionHandler:^(id c) {
            
        } withFailHander:^(int d) {
            
        }];
        
        
        if ([self.allQuestion count] == self.questionIndex + 1) {
            
        }
        else {
         
            [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].imageURL
                                  withLoader:nil
                       withComplitionHandler:^(id c) {
                           
                           
                       } withFailHander:^(int d) {
                           
                       }];
            
            
            [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].successImageUrl
                                  withLoader:nil
                       withComplitionHandler:^(id c) {
                           
                           
                       } withFailHander:^(int d) {
                           
                       }];
        
            
        }
        

        
    }
    else{
        
        if ([self.allQuestion count] == self.questionIndex + 1) {
            
        }
        else {
            
            [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].imageURL
                                  withLoader:nil
                       withComplitionHandler:^(id c) {
                           
                           
                       } withFailHander:^(int d) {
                           
                       }];
            
            
            [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].successImageUrl
                                  withLoader:nil
                       withComplitionHandler:^(id c) {
                           
                           
                       } withFailHander:^(int d) {
                           
                       }];
            
            
        }
        
    }
    
    return _questionView;
    
}


-(InGameScoreView *)gameScoreView {
    
    if (!_gameScoreView) {
        
        
      _gameScoreView =   (InGameScoreView *)[self.view getViewFromNibName:@"InGameScoreView" withWidth:self.scoreContainer.frame.size.width withHeight:self.scoreContainer.frame.size.height];
        [_gameScoreView setUpView];
        
        [self.scoreContainer setBackgroundColor:[UIColor clearColor]];
        
    }
    
    return _gameScoreView;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (IS_IPHONE_5 || IS_IPad) {
        self.questionView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
        
    }

    

    self.gameScoreView.lblScore.text = [NSString stringWithFormat:@"%d",self.scoredPoints];
    

    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self addTopBarButtonByCode];
    
    
    if (IS_IPHONE_5 || IS_IPad) {
        
        self.btnHintConstant.constant = self.btnHintConstant.constant-20;
        self.btnFountItConstant.constant = self.btnFountItConstant.constant -20;
        
    }
    self.scoreToBeAdded = 2;
    
        [self addTopBarButtonByCode];
   AppDelegate *appDelegate =   (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    for (UIButton *currentButton in self.bottomButtons) {
        
        currentButton.titleLabel.font = QuestionViewBottomButtonFonts;
        
        
        if (IS_IPHONE_5 || IS_IPad) {
            
            currentButton.titleLabel.font = [UIFont fontWithName:currentButton.titleLabel.font.fontName size:currentButton.titleLabel.font.pointSize-3];
        
            
        }
        else {
            
        }

        //bottomButtons
    }

    self.viewTitle = self.parkSelected.parkName;
    
    if (IS_IPHONE_5 || IS_IPad) {
        
    }
    else
    self.questionView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    
    
    [self.navigationItem setHidesBackButton:YES];
    
    appDelegate.navBarTitle.attributedText = [self requestTextWithText:self.self.viewTitle];
    
    
    //appDelegate.navBarTitle.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:25];;
    //appDelegate.navBarTitle.font = [UIFont fontWithName:@"FontToUserBlack" size:34];
    
    
    [self.scoreContainer addSubview:self.gameScoreView];
    
    
    
    self.btnFoundIT.layer.cornerRadius = 15;
    self.btnSkip.layer.cornerRadius = 15;
    self.btnHint.layer.cornerRadius = 15;
    
    
    if (self.isQuestion2 == 1) {
        [self.backgroundImage setImage:[UIImage imageNamed:@"Compass_Plant"]];
        
    }
    //
}

- (IBAction)btnHintTapped:(id)sender {
 

    [self.hintView setHidden:NO];
 
    
    self.scoreToBeAdded = 1;
    
    
}

- (IBAction)btnFoundItTapped:(id)sender {
    
    

    
    
    self.scoredPoints = self.scoredPoints + self.scoreToBeAdded;
    
    
    
    [self moveToNextView];
    
    
    
}

-(void)moveToNextView{
    
    
    [self.hintView setHidden:YES];
    
    [self.btnHint setHidden:YES];
    [self.btnSkip setHidden:YES];
    [self.btnFoundIT setHidden:YES];
    
    [self.viewQuestionContainer setHidden:YES];
    [self.scoreContainer setHidden:YES];
    
    self.questionScoreView.imgDottedImage.alpha = 0.0;
    [self.questionScoreView.imgDottedImage setHidden:NO];
    
    
    
    __block UIView *containerViewShowing = self.questionScoreView;
    self.questionScoreView.lblScore.text = [NSString stringWithFormat:@"+%d",self.scoreToBeAdded];
    
    
    
    if (self.questionIndex > 0) {
        
        if (self.questionIndex % 2 == 1) {
            self.questionScoreView.imgDottedImage.image = [UIImage imageNamed:@"flower"];
            
            
        }
        else
        {
            self.questionScoreView.imgDottedImage.image = [UIImage imageNamed:@"dotted-bg"];
            
            
         //greenColorBG
        }

    }
    
    
    [containerViewShowing setFrame:self.view.frame];
    containerViewShowing.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:168.0/255.0 blue:88.0/255.0 alpha:0.85];
    [containerViewShowing setFrame:CGRectMake(0, 0, containerViewShowing.frame.size.width, containerViewShowing.frame.size.height)];
    [self.view addSubview:containerViewShowing];
    
    
    self.otherContainerView = containerViewShowing;

    
    
    

    
    
    if (self.questionIndex == 0) {
        [UIView animateWithDuration:0.8f
                         animations:^{
                           
                             self.questionScoreView.imgDottedImage.alpha = 1.0;
                             
                         } completion:^(BOOL finished) {
                             //Done
                         }];
        
    }
    else if (self.questionIndex % 2 == 1) {
            
        
        
        
        
        [UIView animateWithDuration:0.8f
                         animations:^{
                             self.questionScoreView.imgDottedImage.alpha = 1.0;
                             
                         } completion:^(BOOL finished) {
                             //Done
                         }];
        

        
        
        
        
        }
        else
        {

            [UIView animateWithDuration:0.8f
                             animations:^{
                                 self.questionScoreView.imgDottedImage.alpha = 1.0;
                                 
                             } completion:^(BOOL finished) {
                                 //Done
                             }];
    
            
            
            //greenColorBG
        }
        


 
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self showLoader];
    
        
        [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex].successImageUrl
                              withLoader:nil
                   withComplitionHandler:^(id c) {
        
                                          [self hideLoader];
                       
                       [self performSegueWithIdentifier:@"segueHint" sender:self];
                       
        
                       
                   } withFailHander:^(int d) {
        
                                          [self hideLoader];
                       
                       [self performSegueWithIdentifier:@"segueHint" sender:self];
                       
        
                       
                   }];
        
        
    });
    
    self.scoreToBeAdded = 2;
    
    
    
}
- (IBAction)btnSkipButtonTapped {
    
    
    self.skipping  = YES;
    
    [self.hintView setHidden:YES];
    
    
    [self showLoader];
    
    
    
    if (self.questionIndex == 14) {
                           [self performSegueWithIdentifier:@"segueHint" sender:self];
        return;
    }
    [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].imageURL
                          withLoader:nil
               withComplitionHandler:^(id c) {
                   
                   [self hideLoader];
    
                   
                   [self performSegueWithIdentifier:@"segueHint" sender:self];
                   
               } withFailHander:^(int d) {
    
                   [self hideLoader];
    
                   
                   [self performSegueWithIdentifier:@"segueHint" sender:self];
    
                   
               }];
    
    /*
    [FileManager loadProfileImageUrl:self.allQuestion[self.questionIndex+1].successImageUrl
                          withLoader:nil
               withComplitionHandler:^(id c) {
                   
                   
               } withFailHander:^(int d) {
                   
               }];
    
    */
    
    
    
    
    
    
    

    
}


@end
