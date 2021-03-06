//
//  GainerPointsViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/27/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "GainerPointsViewController.h"
#import "HintView.h"


@interface GainerPointsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnRedeem;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblCongrats;
@property (weak, nonatomic) IBOutlet UILabel *lblYouveCompleted;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceCompleted;
@property (weak, nonatomic) IBOutlet UILabel *lblYourScore;
@property (weak, nonatomic) IBOutlet UILabel *lblYouAreA;
@property (weak, nonatomic) IBOutlet UILabel *lblReSearcher;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contratsSpaceFromTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpacingFromShare;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *congratsConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScoreConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeConmpetedConstant;

@property (weak, nonatomic) IBOutlet UIImageView *dottedBgImage;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *buttonSizes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceFromSCore;
@end

@implementation GainerPointsViewController
- (IBAction)btnRedeemTapped:(id)sender {
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.chiparkpoints.com/"]];
    
    
}

-(NSAttributedString *)reConnectTextWithString:(NSString *)text{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:45];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(0, [attrString length] );
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    

    
    [attrString endEditing];
    
    return attrString;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Earn your 200 Park Points now with code
    
    self.lblYouAreA.text = @"Earn your 200 Park Points now with code";
    if (IS_IPHONE5) {
        self.lblYouAreA.text = @"Earn your 200 Park Points now with code";
        
    }
    self.lblCongrats.font = ScoreViewCongratsFont;
    self.lblCongrats.textColor = AnswerFontColor;
    
    self.lblYouveCompleted.font = ScoreViewYouveCompletedFont;
    
    self.lblYouveCompleted.textColor = AnswerFontColor;
    
    self.lblCongrats.textColor = AnswerFontColor;
    
    self.lblPlaceCompleted.font = ScoreViewPlaceFont;
    self.lblPlaceCompleted.textColor = AnswerFontColor;
    self.lblPlaceCompleted.text = self.currentPark.parkName;
    
    
    self.lblYourScore.font = ScoreYourScoreFont;
    self.lblScore.font = ScoreScoreFont;
    self.lblYouAreA.font = ScoreYouRAFont;
    
    
    if (self.currentPark.itemId == 1) {
        self.lblReSearcher.attributedText = [self reConnectTextWithString:@"RECAPTURE"];
        
    }
    else if (self.currentPark.itemId == 2) {
        self.lblReSearcher.attributedText = [self reConnectTextWithString:@"REDISCOVER"];
        
        
    }
    else if (self.currentPark.itemId == 3) {
        self.lblReSearcher.attributedText = [self reConnectTextWithString:@"RECONNECT"];
        
        
    }
    
    
 
    
    
    for (UIButton *currentButton in self.allButtons) {
        
        
    
        [currentButton.titleLabel setFont:QuestionViewBottomButtonFonts];
        
        currentButton.layer.cornerRadius = 15;
        
        
        if (IS_IPHONE5) {
            
            currentButton.titleLabel.font = [UIFont fontWithName:currentButton.titleLabel.font.fontName size:currentButton.titleLabel.font.pointSize-2];
        
            
            
            
            for (NSLayoutConstraint *currentConstant  in self.buttonSizes) {
                
                
                currentConstant.constant = currentConstant.constant -5;
                
                
            }
            
        }
        
    }
    
    
    
   NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%d%d",self.level.itemId,self.currentPark.itemId];
    
    
    
    
    [self.userDefaults setObject:[NSString stringWithFormat:@"%d",self.scoredPoints] forKey:parkIdToSave];
    
    
   
    
    
    [self addTopBarButtonByCode];
    

    
    [self.navigationItem setHidesBackButton:YES];
    self.lblScore.text = [NSString stringWithFormat:@"%d/30",self.scoredPoints];;
    
    if (IS_IPHONE_6P) {
      //170  170
     
     //   self.topSpaceFromSCore.constant = self.topSpaceFromSCore.constant+140;
       
                self.bottomSpacingFromShare.constant = 90;
        
    }
    else if(IS_IPHONE_6){
        
        self.bottomSpacingFromShare.constant = 50;
        
    }
    else
    if (IS_IPHONE_5) {
        
        self.contratsSpaceFromTop.constant = 20;
 
        self.bottomSpacingFromShare.constant = 20;
 
        self.lblCongrats.font = [UIFont fontWithName:self.lblCongrats.font.fontName size:self.lblCongrats.font.pointSize-5];
        
        self.lblPlaceCompleted.font = [UIFont fontWithName:self.lblPlaceCompleted.font.fontName size:self.lblPlaceCompleted.font.pointSize-4];
        
        
        self.lblYouAreA.font = [UIFont fontWithName:self.lblYouAreA.font.fontName size:self.lblYouAreA.font.pointSize -2];
        
        
    }
    else if(IS_IPad){
        
        self.contratsSpaceFromTop.constant = 10;
        
        self.bottomSpacingFromShare.constant = 15;
        self.lblScore.font = [UIFont fontWithName:self.lblScore.font.fontName size:self.lblScore.font.pointSize-10];
        
            self.lblCongrats.font = [UIFont fontWithName:self.lblCongrats.font.fontName size:self.lblCongrats.font.pointSize-10];
        
        
        self.congratsConstant.constant = 35;
        
        
        self.ScoreConstant.constant = self.ScoreConstant.constant-15;
        
        
        self.lblPlaceCompleted.font = [UIFont fontWithName:self.lblPlaceCompleted.font.fontName size:self.lblPlaceCompleted.font.pointSize-10];
        
        
        self.placeConmpetedConstant.constant = self.placeConmpetedConstant.constant -10;
        
        
        
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navLabel.attributedText = self.requestText;
    self.navLabel.textColor = [UIColor whiteColor];
    
    
    self.sharedDelegate.isPlayingGame = NO;
    
    self.dottedBgImage.alpha = 0.0;
    [self.dottedBgImage setHidden:NO];
    
    
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                         
                         self.dottedBgImage.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
 
                        self.dottedBgImage.alpha = .7;
                         //Done
                     }];
    
}
- (IBAction)btnNext:(id)sender {
    
    
    [self showMyProfileView];
    
    
}
- (IBAction)btnShareTapped:(id)sender {
    
    NSString *formattedString = [NSString stringWithFormat:@"I just scored %d points. Visit http://www.chicagosesideparks.com/ to download the app.",self.scoredPoints];
    
    NSArray* sharedObjects=[NSArray arrayWithObjects:formattedString,  nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]                                                                initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
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
