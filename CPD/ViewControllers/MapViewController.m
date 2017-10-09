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

@end

@implementation MapViewController

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
    
 
    AppDelegate * currentApp = [[UIApplication sharedApplication] delegate];
    
    currentApp.navBarTitle.attributedText = [self requestText];
    
    [self addTopBarButtonByCode];
    
    
    
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
