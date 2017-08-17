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

@property (nonatomic) NSString * park1Score;
@property (nonatomic) NSString * park2Score;
@property (nonatomic) NSString * park3Score;

@end

@implementation ProfileViewController

-(NSString *)park1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@",@"1"];
    
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@",@"2"];
    
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park3Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@",@"3"];
    
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

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
    
   
    
    NSLog(@"");
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
   // self.lblTotalPointsLAbel.attributedText = attributedString ;
    

    self.lblThirdScore.text = [NSString stringWithFormat:@"(%@/30)\nIndian Ridge",self.park3Score];
    
    
    
    self.lblTwoScore.text = [NSString stringWithFormat:@"(%@/30)\nBig Marsh",self.park2Score];
    
    
    
    if ([self.park1Score isEqualToString: @"0"]) {
        self.lblOneScore.font = ProfileViewLevelScoreFont;
        self.lblOneScore.textColor = ProfileViewGrayColor;
        
        
        
    }
    else {

        self.lblOneScore.font = ProfileViewLevelScoreFont;
        self.lblOneScore.textColor = LightGreenTextColor;
    
        
    }

    
    
    if ([self.park2Score isEqualToString: @"0"]) {
        
        self.lblTwoScore.font = ProfileViewLevelScoreFont;
        self.lblTwoScore.textColor = ProfileViewGrayColor;
        
    }
    else {
        
        self.lblTwoScore.font = ProfileViewLevelScoreFont;
        self.lblTwoScore.textColor = LightGreenTextColor;
    }


    
    if ([self.park3Score isEqualToString: @"0"]) {
        
        self.lblThirdScore.font = ProfileViewLevelScoreFont;
        self.lblThirdScore.textColor = ProfileViewGrayColor;
        
        
    }
    else {
        
        self.lblThirdScore.font = ProfileViewLevelScoreFont;
        self.lblThirdScore.textColor = LightGreenTextColor;
        
    }
    

    

    
    

    
    int totalPoints = [self.park1Score intValue] + [self.park2Score intValue]; + [self.park3Score intValue];
    
    
    self.lblTotalPoints.text = [NSString stringWithFormat:@"%d",totalPoints];
    
    self.lblOneScore.text = [NSString stringWithFormat:@"(%@/30)\nHegewisch",self.park1Score];
    
    

    
    
    
    
    self.lblTotalPointsLAbel.text = @"TOTAL POINTS";
 
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    self.navLabel.attributedText = self.requestText;
    self.navLabel.textColor = [UIColor whiteColor];
    
    
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
