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


@property (nonatomic) int levelSelected;

@property (nonatomic,strong) NSMutableArray *questionToSendForPlaying;

@end

@implementation SelectQuizTypeViewController

-(void)typeOneTapped{
    
    self.levelSelected = 0;
    
    
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
                                        
                         } withFailHander:^(int f) {
                            
                             [self performSegueWithIdentifier:@"segueShowQuestion" sender:self];
                             
                             
                         }];
                         
                         

                         

        
    } withFailueHandler:^{
        
    }];
    
    return;
    
    
    


}

-(void)typeTwoTapped{
    self.levelSelected = 1;
    
    
    [self showLoader];
    

    [Question callQuestionsFromLevelId:self.allLevels[self.levelSelected].itemId
                            withParkId:self.selectedPark.itemId
                     ComplitionHandler:^(id result) {
                         
                                                  [self hideLoader];
                         
                         
                         self.questionToSendForPlaying = result;
                         
                         
                         [self performSegueWithIdentifier:@"segueShowQuestion" sender:self];
                         
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




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //[self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    
    [self addTopBarButtonByCode];
    
    if (IS_IPHONE_6P) {
        
        self.viewLevel1DistanceFromLeft.constant = self.viewLevel1DistanceFromLeft.constant +10;
        self.viewLevel2DistanceFromLeft.constant = self.viewLevel2DistanceFromLeft.constant + 10;
        
    }
    else if(IS_IPHONE_6){
        
        
        self.distanceFromTop.constant = self.distanceFromTop.constant - 20;
        
    }
    
    
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
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(self.viewContainerTypeOne.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
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
    layer2.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer2.strokeColor =  nil;
    [self.viewContainerTypeTwo.layer insertSublayer:layer2 atIndex:0];
    
    
    

    
    
    
    //
}



@end
