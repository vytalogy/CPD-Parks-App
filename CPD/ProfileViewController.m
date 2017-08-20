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

@property (weak, nonatomic) IBOutlet UILabel *lblLevel1ThirdScore;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel2ThirdScore;


@property (weak, nonatomic) IBOutlet UILabel *lblLevel1TwoScore;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel2TwoScore;

@property (weak, nonatomic) IBOutlet UILabel *lblLevel1OneScore;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel2OneScore;

@property (weak, nonatomic) IBOutlet UILabel *lblYouRa;
@property (weak, nonatomic) IBOutlet UILabel *lblReaSeacher;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPoints;

@property (nonatomic) NSString * park1Level1Score;
@property (nonatomic) NSString * park1Level2Score;
@property (nonatomic) NSString * park2Level1Score;
@property (nonatomic) NSString * park2Level2Score;
@property (nonatomic) NSString * park3Level1Score;
@property (nonatomic) NSString * park3Level2Score;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation ProfileViewController

-(NSString *)park1Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"1"];
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park1Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"1"];
    
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}


-(NSString *)park2Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"2"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}

-(NSString *)park2Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"2"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
        
    }
    
    return @"0";
    
}




-(NSString *)park3Level1Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"3"];
    id parkInfo = [self.userDefaults objectForKey:parkIdToSave];
    if (parkInfo) {
        return parkInfo;
    }
    
    return @"0";
    
}

-(NSString *)park3Level2Score {
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"2",@"3"];
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
     
     [NSArray arrayWithObjects:[NSNumber numberWithInt:15],
      [NSNumber numberWithInt:10],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.imgIcon.frame.origin.y+self.imgIcon.frame.size.height-54);
    
    
    CGPathAddLineToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.scrollView.frame.size.height+250);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.scrollView.layer addSublayer:shapeLayer];
    
    

    
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
    

   // self.lblLevel1OneScore.text = [NSString stringWithFormat:@"(%@/30)\nHegewisch",self.park1Level1Score];
    
    self.lblLevel1OneScore.attributedText = [self textForScoreWithScore:self.park1Level1Score withLevel:1 withPark:1];
    self.lblLevel2OneScore.attributedText = [self textForScoreWithScore:self.park1Level2Score withLevel:2 withPark:1];
    
    
    
    self.lblLevel1TwoScore.attributedText = [self textForScoreWithScore:self.park2Level1Score withLevel:1 withPark:1];
    self.lblLevel2TwoScore.attributedText = [self textForScoreWithScore:self.park2Level1Score withLevel:2 withPark:1];
    
    
    
    self.lblLevel1ThirdScore.attributedText = [self textForScoreWithScore:self.park3Level1Score withLevel:1 withPark:1];
    self.lblLevel2ThirdScore.attributedText = [self textForScoreWithScore:self.park3Level2Score withLevel:2 withPark:1];
    
    
    
    
    

    
    
    if ([self.park1Level1Score isEqualToString: @"0"]) {

        self.lblLevel1OneScore.textColor = ProfileViewGrayColor;
        
        
        
    }
    else {


        self.lblLevel1OneScore.textColor = LightGreenTextColor;
    
        
    }
    
    if ([self.park1Level2Score isEqualToString: @"0"]) {
        
        self.lblLevel2OneScore.textColor = ProfileViewGrayColor;
        
        
        
    }
    else {
        
        
        self.lblLevel2OneScore.textColor = LightGreenTextColor;
        
        
    }
    

    
    
    
    if ([self.park2Level1Score isEqualToString: @"0"]) {
        

        self.lblLevel1TwoScore.textColor = ProfileViewGrayColor;
        
    }
    else {
        
        self.lblLevel1TwoScore.textColor = LightGreenTextColor;
    }
    if ([self.park2Level2Score isEqualToString: @"0"]) {
        
        
        self.lblLevel2TwoScore.textColor = ProfileViewGrayColor;
        
    }
    else {
        
        self.lblLevel2TwoScore.textColor = LightGreenTextColor;
    }
    


    
    if ([self.park3Level1Score isEqualToString: @"0"]) {
        

        self.lblLevel1ThirdScore.textColor = ProfileViewGrayColor;
        
        
    }
    else {
        

        self.lblLevel1ThirdScore.textColor = LightGreenTextColor;
        
    }
    
    
    if ([self.park3Level2Score isEqualToString: @"0"]) {
        
        
        self.lblLevel2ThirdScore.textColor = ProfileViewGrayColor;
        
        
    }
    else {
        
        
        self.lblLevel2ThirdScore.textColor = LightGreenTextColor;
        
    }
    
    

    

    
    

    
    int totalPoints = [self.park1Level1Score intValue] + [self.park2Level1Score intValue]; + [self.park3Level1Score intValue];
    
    
    self.lblTotalPoints.text = [NSString stringWithFormat:@"%d",totalPoints];
    

    

    
    
    
    
    self.lblTotalPointsLAbel.text = @"TOTAL\nPOINTS";
 
    

    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    self.navLabel.attributedText = self.requestText;
    self.navLabel.textColor = [UIColor whiteColor];
    
    
}



@end
