//
//  MainMenuViewController.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MainMenuViewController.h"
#import <CoreText/CoreText.h>
#import "AppDelegate.h"
#import "SelectQuizTypeViewController.h"

@interface MainMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *firstItemContainer;
@property (weak, nonatomic) IBOutlet UIView *secondItemContainer;
@property (weak, nonatomic) IBOutlet UIView *thirdItemContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblHegewish;
@property (weak, nonatomic) IBOutlet UILabel *lblBigMarch;
@property (weak, nonatomic) IBOutlet UILabel *lblIndian;
@property (weak, nonatomic) IBOutlet UILabel *lblWhere;

@property (nonatomic) int viewToOpen;

@property (nonatomic,strong) NSArray * allParks;

@end

@implementation MainMenuViewController

-(void)labelTapped{
    
    
    
    
    
    self.viewToOpen = 0;
    
    [self performSegueWithIdentifier:@"segueShowQuizType" sender:self];
    NSLog(@"Tapped");
    
    

    
}


-(void)label2Tapped{
    

    self.viewToOpen = 1;
    
    [self performSegueWithIdentifier:@"segueShowQuizType" sender:self];
    NSLog(@"Tapped");
    
    
    
}

-(void)label3Tapped{
    
    self.viewToOpen = 2;
    [self performSegueWithIdentifier:@"segueShowQuizType" sender:self];
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
    if ([segue.destinationViewController isKindOfClass:[SelectQuizTypeViewController class]]) {
        
        
        SelectQuizTypeViewController *destination = (SelectQuizTypeViewController *)segue.destinationViewController;
        
        
        destination.selectedPark = self.allParks[self.viewToOpen];
        

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //[self showLoader];
    

   [self showLoader];
    
    [Parks callGetAllParksComplitionHandler:^(id result) {
        
        NSLog(@"");
        
        [self hideLoader];
        
        
        self.allParks = result;
        

        
    } withFailueHandler:^{
        [self hideLoader];
        
        
    }];
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.lblHegewish addGestureRecognizer:tapGestureRecognizer];
    self.lblHegewish.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label2Tapped)];
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    [self.lblBigMarch addGestureRecognizer:tapGestureRecognizer2];
    self.lblBigMarch.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label3Tapped)];
    tapGestureRecognizer3.numberOfTapsRequired = 1;
    [self.lblIndian addGestureRecognizer:tapGestureRecognizer3];
    self.lblIndian.userInteractionEnabled = YES;
    
    
    
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    
    self.lblTitle.text = @"Where will \nyou start\nyour quest?";
    

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"request"];
    NSString *boldFontName = [UIFont fontWithName:@"RobotoSlab-Bold" size:30];

    NSString *normalFont = [UIFont fontWithName:@"RobotoSlab-Regular" size:30];
    
    [attrString beginEditing];

    NSRange boldedRange = NSMakeRange(2, 5);
    NSRange normalRange2 = NSMakeRange(0, 2);

    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];

    
    
    UILabel *titleLabel = [UILabel new];
    [titleLabel setFrame:CGRectMake(10, 0, 250, 44)];
    //titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:20];
   // titleLabel.text = @"request";
    titleLabel.attributedText = attrString;
    
    
    [tmpView addSubview:titleLabel];
    

     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     appDelegate.navBarTitle = titleLabel;
    
    titleLabel.textColor = self.lblWhere.textColor;
    
    
    self.firstItemContainer.backgroundColor = [UIColor clearColor];
    
    self.secondItemContainer.backgroundColor = [UIColor clearColor];
    self.thirdItemContainer.backgroundColor = [UIColor clearColor];
    
    //
    [self.navigationController.navigationBar addSubview:tmpView];
    
        [self.navigationController setNavigationBarHidden:NO animated:NO];
 

}

-(void)mainMenuButtonTapped{
    
    

}

- (IBAction)btnMenuTapped:(UIBarButtonItem *)sender {
    

    
    [self showMenuViewController];
    

    //[self performSegueWithIdentifier:@"segueMenu" sender:self];
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path addLineToPoint:CGPointMake(_firstItemContainer.frame.size.width, 0)]; // top right corner
    [path addLineToPoint:CGPointMake(_firstItemContainer.frame.size.width, 63)]; // bottom right corner
    [path closePath];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer.strokeColor =  nil;
    [self.firstItemContainer.layer insertSublayer:layer atIndex:0];
    
    

    
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path2 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path2 addLineToPoint:CGPointMake(_secondItemContainer.frame.size.width, 0)]; // top right corner-
    [path2 addLineToPoint:CGPointMake(_secondItemContainer.frame.size.width, 63)]; // bottom right corner
    [path2 closePath];
    
    layer2.path = path2.CGPath;
    layer2.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer2.strokeColor =  nil;
    [self.secondItemContainer.layer insertSublayer:layer2 atIndex:0];
    
    
    
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(23, 63)]; // bottom left corner
    [path3 addLineToPoint:CGPointMake(0, 0)]; // top middle
    [path3 addLineToPoint:CGPointMake(_thirdItemContainer.frame.size.width, 0)]; // top right corner-
    [path3 addLineToPoint:CGPointMake(_thirdItemContainer.frame.size.width, 63)]; // bottom right corner
    [path3 closePath];
    
    layer3.path = path3.CGPath;
    layer3.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9].CGColor;
    layer3.strokeColor =  nil;
    [self.thirdItemContainer.layer insertSublayer:layer3 atIndex:0];
    
    
    

    
 //
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
