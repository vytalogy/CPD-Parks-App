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
#import "ProfileViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;

@property (nonatomic) int currentSelectedImage;

@end

@implementation MapViewController

-(void)makeAllButtonsNormal{
 
    for (UIButton * currentButton in self.allButtons) {
    
        [currentButton setBackgroundColor:[UIColor whiteColor]];
        [currentButton setTitleColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
}
- (IBAction)btnHegewishMarchTapped:(UIButton *)sender {
    
    self.currentSelectedImage = 0;
    
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
    
    self.currentSelectedImage = 1;
    
    
}
- (IBAction)btnBigMarshTapped:(UIButton *)sender {
    
    self.currentSelectedImage = 2;
    
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

-(void)mainMenuButtonTapped{
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)tapDetected{
    

    if (self.currentSelectedImage == 0) {
     
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:@"comgooglemaps://?center=41.655496,-87.564370&zoom=15"]];
        } else {
            NSLog(@"Can't use comgooglemaps://");
            NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f",41.655496, -87.564370];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
            
        }
        
    }
    else if (self.currentSelectedImage == 1) {
        
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:@"comgooglemaps://?center=41.6800257,-87.5606165&zoom=15"]];
        } else {
            NSLog(@"Can't use comgooglemaps://");
            NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f",41.6800257,-87.5606165];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
            
        }
        
    }
    else if (self.currentSelectedImage == 2) {
        
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:@"comgooglemaps://?center=41.690329,-87.5705071&zoom=15"]];
        } else {
            NSLog(@"Can't use comgooglemaps://");
            NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f",41.690329,-87.5705071];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];
            
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
 
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.mapImage setUserInteractionEnabled:YES];
    [self.mapImage addGestureRecognizer:singleTap];
    
    
    
 
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

-(void)mapButtonTapped{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)profileButtonTapped{
    
    
    [self showMyProfileView];
    
    
    
}

-(void)showMyProfileView{
    
    
    
    ProfileViewController *destination = (ProfileViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"ProfileViewController"];
    
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:destination animated:NO];
    
    
    
    
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
