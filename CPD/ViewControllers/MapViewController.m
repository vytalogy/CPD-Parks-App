//
//  MapViewController.m
//  CDP
//
//  Created by Tauqeer Ahmed on 10/9/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;

@end

@implementation MapViewController

-(void)makeAllButtonsNormal{
 
    for (UIButton * currentButton in self.allButtons) {
    
        [currentButton setBackgroundColor:[UIColor whiteColor]];
        [currentButton setTitleColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
}
- (IBAction)btnHegewishMarchTapped:(UIButton *)sender {
    
    
    //
    
    [self makeAllButtonsNormal];
    
    [sender setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [self.mapImage setImage:[UIImage imageNamed:@"HegewischMarsh-Map"]];
    
    
}
- (IBAction)btnIndianRidgeTapped:(UIButton *)sender {
    //
    [self makeAllButtonsNormal];
    [sender setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    [self.mapImage setImage:[UIImage imageNamed:@"IndianRidgeMarshMap"]];
    
    
}
- (IBAction)btnBigMarshTapped:(UIButton *)sender {
    
    [self makeAllButtonsNormal];
    
    [sender setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
 
    [self.mapImage setImage:[UIImage imageNamed:@"BigMarshMap"]];
    
    
}

-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId{
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle: nil];
    return (UIViewController *)[mainStoryboard
                                instantiateViewControllerWithIdentifier: viewId];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
    
 
    AppDelegate * currentApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    currentApp.navBarTitle.attributedText = [self requestText];
    
    [self addTopBarButtonByCode];
    
    if (IS_IPHONE_6) {
        
        for (UIButton * currentButton in self.allButtons) {
        
            [currentButton.titleLabel setFont:[UIFont fontWithName:currentButton.titleLabel.font.fontName size:currentButton.titleLabel.font.pointSize-1]];
            
        }
    }
    else     if (IS_IPHONE5 || IS_IPad || IS_IPOD) {
        
        for (UIButton * currentButton in self.allButtons) {
            
            [currentButton.titleLabel setFont:[UIFont fontWithName:currentButton.titleLabel.font.fontName size:currentButton.titleLabel.font.pointSize-3]];
            
        }
    }
    
}

-(NSAttributedString *)requestText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"Map"];
    id boldFontName = [UIFont fontWithName:FontToUserBlack size:36];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:36];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(0, 3);

    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString endEditing];
    
    return attrString;
    
}

-(void)showMenuViewController{
    
    MenuViewController * menuViewController =
    (MenuViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MenuViewController"];
    
    menuViewController.delegate = self;
    
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    
    [self presentViewController:menuViewController animated:NO completion:^{
        
    }];
    
}

-(void)addTopBarButtonByCode {
    
    //
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"menu-icon"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(showMenuViewController)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
    
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
