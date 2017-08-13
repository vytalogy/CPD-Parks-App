//
//  GainerPointsViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/27/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "GainerPointsViewController.h"

@interface GainerPointsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblCongrats;
@property (weak, nonatomic) IBOutlet UILabel *lblYouveCompleted;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceCompleted;
@property (weak, nonatomic) IBOutlet UILabel *lblYourScore;
@property (weak, nonatomic) IBOutlet UILabel *lblYouAreA;
@property (weak, nonatomic) IBOutlet UILabel *lblReSearcher;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@end

@implementation GainerPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.lblCongrats.font = ScoreViewCongratsFont;
    self.lblCongrats.textColor = AnswerFontColor;
    
    self.lblYouveCompleted.font = ScoreViewYouveCompletedFont;
    self.lblCongrats.textColor = AnswerFontColor;
    
    self.lblPlaceCompleted.font = ScoreViewPlaceFont;
    self.lblPlaceCompleted.textColor = AnswerFontColor;
    
    
    self.lblYourScore.font = ScoreYourScoreFont;
    self.lblScore.font = ScoreScoreFont;
    self.lblYouAreA.font = ScoreYouRAFont;
    //self.lblReSearcher.font = ScoreViewPlaceFont;
    
    
    
    for (UIButton *currentButton in self.allButtons) {
        
        
        [currentButton.titleLabel setFont:QuestionViewBottomButtonFonts];
        
    }
    
    
    
    
    
    [self addTopBarButtonByCode];
    
    self.btnNext.layer.cornerRadius = 15;
    self.btnShare.layer.cornerRadius = 15;
  
    //  self.btnBonus.layer.cornerRadius = 15;
    
    [self.navigationItem setHidesBackButton:YES];
    self.lblScore.text = [NSString stringWithFormat:@"%d/30",self.scoredPoints];;
    
    
}
- (IBAction)btnNext:(id)sender {
    
    
    [self performSegueWithIdentifier:@"segueMyProfile" sender:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
