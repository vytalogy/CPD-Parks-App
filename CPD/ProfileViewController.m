//
//  ProfileViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 8/5/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "ProfileViewController.h"
#import "IQMediaPickerController.h"
#import "IQFileManager.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IQImagePreviewViewController.h"
#import "CropImage.h"
#import "RulesView.h"
#import "CropImageViewController.h"


@interface ProfileViewController ()<IQMediaPickerControllerDelegate,UINavigationControllerDelegate,CropImageDelegate>

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
@property (weak, nonatomic) IBOutlet UIImageView *viewStart;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic) BOOL pickerHasAlreadyBeenShown;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpacingForStar;


@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet UIImageView *eyeGlass;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel1One;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel1One;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel2One;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel2One;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel1Two;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel1Two;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel2Two;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel2Two;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel1Three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel1Three;

@property (weak, nonatomic) IBOutlet UIImageView *badgeLevel2Three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLevel2Three;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftSpacing;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *spacingLeftBadges;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollWidthConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewLeftSpacing;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpacing1Level1;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resetXConst;
@property (nonatomic,strong) RulesView *hintView;


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
     
     [NSArray arrayWithObjects:[NSNumber numberWithInt:15],
      [NSNumber numberWithInt:10],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.imgIcon.frame.origin.y+self.imgIcon.frame.size.height-54);
    
    
    if (IS_IPHONE_5) {
        CGPathAddLineToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.scrollView.contentSize.height);
        
        
        
        
    }
    else     if (IS_IPad) {
        CGPathAddLineToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.scrollView.contentSize.height);
        
        
        
        
    }
    else{
        CGPathAddLineToPoint(path, NULL, self.imgIcon.frame.origin.x+self.imgIcon.frame.size.width/2, self.scrollView.contentSize.height);
    
        
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.scrollView.layer addSublayer:shapeLayer];
    
    
    
    
    
    [self.btnReset.titleLabel setFont:QuestionViewBottomButtonFonts];
    
    self.btnReset.layer.cornerRadius = 15;
    
    
    

    
    id c = [FileManager getImage];
    
    if (c) {
        
        self.pickerHasAlreadyBeenShown = true;
        
        [self.imgIcon setImage:c];
     
        [self.imgIcon roundTheView];
        
        
    }

    
    if (!self.pickerHasAlreadyBeenShown) {
        
        [self callAlertViewControllerWithTitle:@"" withMessage:@"Choose a profile picture" withOkButtonTitle:@"OK" withCancleTitle:nil withOKHandler:^{
            
            self.pickerHasAlreadyBeenShown = YES;
            IQMediaPickerController *controller = [[IQMediaPickerController alloc] init];
            controller.delegate = self;
            
            [controller setSourceType:IQMediaPickerControllerSourceTypeLibrary];
            
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            
            
            
            
            [mediaTypes addObject:@(IQMediaPickerControllerMediaTypePhoto)];
            
            [controller setMediaTypes:mediaTypes];
            controller.captureDevice = IQMediaPickerControllerCameraDeviceFront;
            

            controller.allowsPickingMultipleItems = NO;
            controller.maximumItemCount = 1;
            
            
            [self presentViewController:controller animated:YES completion:nil];
            
            
            
        } withCancelHandler:^{
            
        }];
        

        
    }
    
    
        [self.scrollView bringSubviewToFront:self.eyeGlass];
 
    if ([self.park1Level1Score intValue] > 0) {
        
        
        
        
        self.constantLevel1One.constant = self.stackView.frame.origin.y+5;
        
        [self.badgeLevel1One setHidden:NO];
        
        
        [self.scrollView bringSubviewToFront:self.badgeLevel1One];
    }
     if ([self.park2Level1Score intValue] > 0) {
        

         
         
        
        self.constantLevel1Two.constant = self.stackView.frame.origin.y+self.lblLevel1TwoScore.frame.origin.y+5;
        
        
        [self.badgeLevel1Two setHidden:NO];
        
        
        [self.scrollView bringSubviewToFront:self.badgeLevel1Two];
         
       // [self.scrollView bringSubviewToFront:self.viewStart];
    }
    
        if ([self.park1Level2Score intValue] > 0) {
            
            
            
            
            self.constantLevel2One.constant = self.stackView.frame.origin.y+self.lblLevel2OneScore.frame.origin.y;
            
            
            [self.badgeLevel2One setHidden:NO];
            
            
            [self.scrollView bringSubviewToFront:self.badgeLevel2One];
            
        }
         if ([self.park2Level2Score intValue] > 0) {
            
       
            self.constantLevel2Two.constant = self.stackView.frame.origin.y+self.lblLevel2TwoScore.frame.origin.y+5;
            
            
            [self.badgeLevel2Two setHidden:NO];
            
            
            [self.scrollView bringSubviewToFront:self.badgeLevel2Two];
        }
         if ([self.park3Level1Score intValue] > 0 ){
            
            
            
            

             
            self.constantLevel1Three.constant = self.stackView.frame.origin.y+self.lblLevel1ThirdScore.frame.origin.y+5;
            
            
            [self.badgeLevel1Three setHidden:NO];
            
            
            [self.scrollView bringSubviewToFront:self.badgeLevel1Three];
        }
         if ([self.park3Level2Score intValue] > 0) {
            


            self.constantLevel2Three.constant = self.stackView.frame.origin.y+self.lblLevel2ThirdScore.frame.origin.y+5;
            
            [self.badgeLevel2Three setHidden:NO];
            [self.scrollView bringSubviewToFront:self.badgeLevel2Three];
        }
    
    
    
    
    
}
- (IBAction)btnShowImagePicker:(id)sender {

    self.pickerHasAlreadyBeenShown = YES;
    IQMediaPickerController *controller = [[IQMediaPickerController alloc] init];
    controller.delegate = self;
    
    [controller setSourceType:IQMediaPickerControllerSourceTypeLibrary];
    
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    
    
    
    
    [mediaTypes addObject:@(IQMediaPickerControllerMediaTypePhoto)];
    
    [controller setMediaTypes:mediaTypes];
    controller.captureDevice = IQMediaPickerControllerCameraDeviceFront;
    
    
    controller.allowsPickingMultipleItems = NO;
    controller.maximumItemCount = 1;
    
    
    [self presentViewController:controller animated:YES completion:nil];
    

    
    
}


- (void) imageCropedInCircle : (UIImage *) Croppedimage{
    
    
    [self.imgIcon roundTheView];
    
    
    UIImage *tmp = [self imageWithImage:Croppedimage scaledToWidth:self.imgIcon.frame.size.height*2];
    
    if (IS_IPHONE_6P) {
        tmp = [self imageWithImage:Croppedimage scaledToWidth:self.imgIcon.frame.size.height*3];
        
        
    }
    [self.imgIcon setImage:tmp];
    
    
    NSData *imageData = UIImagePNGRepresentation(tmp);

    
    [FileManager saveProfileImageToDisk:imageData fileName:@"Photo"];
    
    

    
    NSLog(@"");;

    
    
    
    
}
- (void)mediaPickerController:(IQMediaPickerController*)controller didFinishMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"Info: %@",info);
    

    
    
    id image = [[[info objectForKey:@"IQMediaTypeImage"] firstObject] objectForKey:@"IQMediaImage"];
    
    
    NSLog(@"");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        CropImageViewController *cropImageViewController = [[CropImageViewController alloc]initWithNibName:@"CropImageViewController" bundle:nil];
        cropImageViewController.image = image;
        cropImageViewController.delegate = self;
        
        [self presentViewController:cropImageViewController animated:YES completion:^{
            
            
        }];
        

        
    }];
    
}

-(void)closeRulesView{
    [self.view sendSubviewToBack:self.hintView];
    
    self.hintView.hidden = YES;
    
    
    
    
}
-(void)getStarted{
    
    [self.view sendSubviewToBack:self.hintView];
    
    self.hintView.hidden = YES;
    
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    
    
    // CGRect toVisible = CGRectMake(0, 0, self, height);
    
    //[scrollView scrollRectToVisible:toVisible animated:YES];
    
    
    NSString *parkIdToSave =  [NSString stringWithFormat:@"Park%@%@",@"1",@"1"];
    NSString *parkIdToSave2 =  [NSString stringWithFormat:@"Park%@%@",@"2",@"1"];
    NSString *parkIdToSave3 =  [NSString stringWithFormat:@"Park%@%@",@"1",@"2"];
    NSString *parkIdToSave4 =  [NSString stringWithFormat:@"Park%@%@",@"2",@"2"];
    NSString *parkIdToSave5 =  [NSString stringWithFormat:@"Park%@%@",@"1",@"3"];
    NSString *parkIdToSave6 =  [NSString stringWithFormat:@"Park%@%@",@"2",@"3"];
    
    
    
    [self.userDefaults setObject:nil forKey:parkIdToSave];
    [self.userDefaults setObject:nil forKey:parkIdToSave2];
    
    [self.userDefaults setObject:nil forKey:parkIdToSave3];
    [self.userDefaults setObject:nil forKey:parkIdToSave4];
    [self.userDefaults setObject:nil forKey:parkIdToSave5];
    [self.userDefaults setObject:nil forKey:parkIdToSave6];
    
    
    [self.badgeLevel1One setHidden:YES];
    [self.badgeLevel2One setHidden:YES];
    
    [self.badgeLevel1Two setHidden:YES];
    [self.badgeLevel2Two setHidden:YES];
    
    [self.badgeLevel1Three setHidden:YES];
    [self.badgeLevel2Three setHidden:YES];
    
    
    [self doLoadingStuff];
    
    
    
}
-(RulesView *)hintView {
    //@property (nonatomic,strong) RulesView * rulesViews;
    if (!_hintView) {
        
        _hintView =   (RulesView *)[self.view getViewFromNibName:@"RulesViewWithButton2"
                                                         withWidth:self.view.frame.size.width
                                                        withHeight:self.view.frame.size.height];
        
        
        [_hintView setUpView];
        
        
        
        
        [_hintView.btnClose addTarget:self action:@selector(closeRulesView) forControlEvents:UIControlEventTouchUpInside];
        
        [_hintView.btnGetStarted addTarget:self action:@selector(getStarted) forControlEvents:UIControlEventTouchUpInside];
        
        
        _hintView.labelHeightTop.constant =0;
        
        _hintView.lblTitle.text = @"Are you sure you want to Reset?";
        _hintView.lblRules.text = @"This action will remove your previous scores.";
        
        [_hintView.btnGetStarted setTitle:@"OK" forState:UIControlStateNormal];
        
        [self.view addSubview:_hintView];
        
        
    }
    else {
        
        //_hintView.hidden = NO;
        
    }
    return _hintView;
    
}

- (IBAction)btnRestTapped:(id)sender {
    
    self.hintView.hidden = NO;
    
    [self.view bringSubviewToFront:self.hintView];
    
    return;
    
    
    [self callAlertViewControllerWithTitle:@"Are you sure you want to reset?" withMessage:@"It will delete all your saved progress." withOkButtonTitle:@"Ok" withCancleTitle:@"Cancel" withOKHandler:^{
        
      

        
        
        
    } withCancelHandler:^{
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    if (IS_IPHONE_5) {
        
        self.resetXConst.constant = 15;
        
        
        self.imageViewLeftSpacing.constant =self.imageViewLeftSpacing.constant-22;
        
        self.leftSpacing1Level1.constant = self.leftSpacing1Level1.constant-22;;
        
        
        self.scrollWidthConstant.constant = self.scrollWidthConstant.constant - 55;
        
        self.stackViewLeftSpacing.constant = self.stackViewLeftSpacing.constant - 35;
        
        
        
        for (NSLayoutConstraint * currentItemContstant in self.spacingLeftBadges) {
            
            currentItemContstant.constant = currentItemContstant.constant -22;
            
            
        }
    }
    else if(IS_IPad){
        self.resetXConst.constant = 15;
        
        self.imageViewLeftSpacing.constant =self.imageViewLeftSpacing.constant-22;
        
        self.leftSpacing1Level1.constant = self.leftSpacing1Level1.constant-22;;
        
        
        self.scrollWidthConstant.constant = self.scrollWidthConstant.constant - 55;
        
        self.stackViewLeftSpacing.constant = self.stackViewLeftSpacing.constant - 35;
        
        
        
        for (NSLayoutConstraint * currentItemContstant in self.spacingLeftBadges) {
            
            currentItemContstant.constant = currentItemContstant.constant -22;
            
            
        }
        
    }
    else if(IS_IPHONE_6){
        
        
        self.scrollWidthConstant.constant = self.scrollWidthConstant.constant - 30;
        self.resetXConst.constant = 23;
        
        
    }
    
    NSLog(@"");
        [self addTopBarButtonByCode];
    
        [self.navigationItem setHidesBackButton:YES];
 
    

    
    
    

    
    
   
    self.lblReaSeacher.attributedText = self.reSearcherText;
    
    self.lblYouRa.font = ProfileViewYouAreA;
    
    self.lblTotalPointsLAbel.font = ProfileViewTotalPointsLabelFont;
    
    self.lblTotalPoints.textColor = LightGreenTextColor;
    
   
    
    

    
    

    
    
 
    [self doLoadingStuff];
    
    

    
}

-(void)doLoadingStuff{
    self.lblTotalPoints.font =ProfileViewTotalPointsScoreFont;
  
    
    NSString *labelText = @"TOTAL\nPOINTS";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:-10];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    self.lblLevel1OneScore.attributedText = [self textForScoreWithScore:self.park1Level1Score withLevel:1 withPark:1];
    self.lblLevel2OneScore.attributedText = [self textForScoreWithScore:self.park1Level2Score withLevel:2 withPark:1];
    
    
    
    self.lblLevel1TwoScore.attributedText = [self textForScoreWithScore:self.park2Level1Score withLevel:1 withPark:2];
    self.lblLevel2TwoScore.attributedText = [self textForScoreWithScore:self.park2Level2Score withLevel:2 withPark:2];
    
    
    
    self.lblLevel1ThirdScore.attributedText = [self textForScoreWithScore:self.park3Level1Score withLevel:1 withPark:3];
    self.lblLevel2ThirdScore.attributedText = [self textForScoreWithScore:self.park3Level2Score withLevel:2 withPark:3];
    
    
    
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
    
    
    

    
    int totalPoints = self.totalPoints;
    
    
    
    self.lblReaSeacher.attributedText = self.attributedTextPointsTitle;
    
    self.lblTotalPoints.text = [NSString stringWithFormat:@"%d",totalPoints];
    
    self.lblTotalPointsLAbel.text = @"TOTAL\nPOINTS";
 
    if (IS_IPHONE_6P) {
        
    }
    else
    if (totalPoints > 99) {
        
        self.lblTotalPoints.font = [UIFont fontWithName:self.lblTotalPoints.font.fontName size:self.lblTotalPoints.font.pointSize -20];
        
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    self.navLabel.attributedText = self.requestText;
    self.navLabel.textColor = [UIColor whiteColor];
    
    
}



@end
