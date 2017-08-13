//
//  ProfileViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 8/5/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalPointsLAbel;
@property (weak, nonatomic) IBOutlet UILabel *lblThirdScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *lblOneScore;
@property (weak, nonatomic) IBOutlet UILabel *lblYouRa;
@property (weak, nonatomic) IBOutlet UILabel *lblReaSeacher;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPoints;

@end

@implementation ProfileViewController

-(void)viewDidAppear:(BOOL)animated{
    

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.view.bounds];
    [shapeLayer setPosition:self.view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.imgIcon.frame.origin.y+self.imgIcon.frame.size.height-54);
    
    
    CGPathAddLineToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.view.frame.size.height);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.view.layer addSublayer:shapeLayer];
    
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self addTopBarButtonByCode];
    
        [self.navigationItem setHidesBackButton:YES];
 
    
    self.lblReaSeacher.attributedText = self.reSearcherText;
    
    self.lblYouRa.font = ProfileViewYouAreA;
    
    self.lblTotalPointsLAbel.font = ProfileViewTotalPointsLabelFont;
    self.lblTotalPoints.font =ProfileViewTotalPointsScoreFont;
    
    self.lblTotalPoints.textColor = LightGreenTextColor;
    
    
    NSString *labelText = @"TOTAL\nPOINTS";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:-10];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.lblTotalPointsLAbel.attributedText = attributedString ;
    

    self.lblThirdScore.text = @"(28/30)\nIndian Ridge";
    
    
    self.lblTwoScore.text = @"(28/30)\nBig Marsh";
    
    self.lblOneScore.font = ProfileViewLevelScoreFont;
    self.lblTwoScore.textColor = LightGreenTextColor;
    
    
    self.lblTwoScore.font = ProfileViewLevelScoreFont;
    self.lblTwoScore.textColor = ProfileViewGrayColor;
    
    self.lblThirdScore.font = ProfileViewLevelScoreFont;
    self.lblThirdScore.textColor = ProfileViewGrayColor;
    
    
    
    self.lblOneScore.text = @"(28/30)\nHegewisch";
    
    
    self.lblTotalPointsLAbel.text = @"TOTAL POINTS";
 
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    self.navLabel.attributedText = self.requestText;
    
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
