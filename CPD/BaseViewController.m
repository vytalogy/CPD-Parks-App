//
//  BaseViewController.m
//  GChat
//
//  Created by Tauqeer on 2014-09-26.
//  Copyright (c) 2014 Carlin. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "DateFormatter.h"
#import <AVFoundation/AVFoundation.h>

#import "ProfileViewController.h"


@import AVKit;


@interface BaseViewController ()<MBProgressHUDDelegate,AVPlayerViewControllerDelegate,UISearchBarDelegate>{
    
    MBProgressHUD *hud;
}


@end

@implementation BaseViewController


- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self hideLoader];
    

    NSLog(@"");
[playerViewController dismissViewControllerAnimated:YES completion:^{
    
}];
    

}
-(void)setViewTitle:(NSString *)viewTitle{

    self.viewTitleContainer.backgroundColor =[UIColor clearColor];
    _viewTitle = viewTitle;
}
- (BOOL) isInternetConnectionAvailable
{
    Reachability *internet = [Reachability reachabilityWithHostName: @"www.google.com"];
    NetworkStatus netStatus = [internet currentReachabilityStatus];
    bool netConnection = false;
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"Access Not Available");
            netConnection = false;
            break;
        }
        case ReachableViaWWAN:
        {
            netConnection = true;
            break;
        }
        case ReachableViaWiFi:
        {
            netConnection = true;
            break;
        }
    }
    return netConnection;
}

-(void)setWhenDidFilesWereDeletedLastTime{
    
    [self.userDefaults setObject:[DateFormatter showDate:[NSDate date] inStringFormate:@"dd-MM-yy"] forKey:@"WhenDidFilesWereDeletedLastTime"];
    
}


-(int)whenDidFilesWereDeletedLastTime{
    
    
    
    return 1;
    
}

-(void)EmptySandbox
{
    
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
}

-(NSString *)salt{
    
    return serviceSalt;
    
}

+(NSString *)giveServiceSalt{
    
    return serviceSalt;
    
}
-(NSUserDefaults *)userDefaults
{
    
    if (!_userDefaults) {
         _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}


-(void)topImageViewTapped{
    
}

-(void)mainMenuButtonTapped{
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)addTopBarButtonByCode {
    
    //
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"menu-button.png"]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(showMenuViewController)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    /*
   
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-1"]];
    [topImageView setFrame:CGRectMake(0, 0, 84, 26)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageViewTapped)];
    singleTap.numberOfTapsRequired = 1;
    [topImageView setUserInteractionEnabled:YES];
   [topImageView addGestureRecognizer:singleTap];

    
    //337 × 102
    //84 x 26
    [self.navigationController.navigationItem.titleView addSubview:topImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"Title";
    [label sizeToFit];
    self.navigationItem.titleView = topImageView;
    [self.navigationController setNavigationBarHidden:NO animated:YES];*/
    
}






-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
 
         [self.navigationController setNavigationBarHidden:NO animated:YES];

}



-(void)topBarButtonTapped{
    
    NSLog(@"Top Bar Button Tapped");
    

    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"SelectCityViewController"];
    [self.navigationController pushViewController:currentSearch animated:YES];
}
-(void)btnLocationTapped{
    
    id currentSearch = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MapViewController"];
    
    
    if ([self isKindOfClass:[currentSearch class]]) {
        return;
    }
    
    [self.navigationController pushViewController:currentSearch animated:YES];
}







-(void)setMyMap{

    
    
}
- (void)openMapsWithDirectionsTo:(CLLocationCoordinate2D)to latitude:(double)latitude longitude:(double)longitude{
    
    CLLocationCoordinate2D myLocation;
    myLocation.latitude = latitude;
    myLocation.longitude = longitude;
    
    NSMutableString *mapURL = [NSMutableString stringWithString:@"http://maps.google.com/maps?"];
    [mapURL appendFormat:@"saddr=%f,%f", myLocation.latitude, myLocation.longitude];
    [mapURL appendFormat:@"&daddr=%f,%f", to.latitude, to.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mapURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



-(void)restartLaoder{
    [self createNewLoader];
    
}
-(void)stopLoader{
    
    [hud removeFromSuperview];
}

-(void)createNewLoaderForModal{
    
    id c = self.navigationController.view;
    
    if (!c) {
        c = self.view;
    }
    hud = [[MBProgressHUD alloc] initWithView:c];
    
    
    [self.view addSubview:hud];
    hud.labelText = @"Posting";
    
    [hud show:YES];
    
}
- (void)createNewLoader{
    
    id c = self.navigationController.view;
    
    if (!c) {
        c = self.view;
    }
	hud = [[MBProgressHUD alloc] initWithView:c];
    
    
	[self.navigationController.view addSubview:hud];
	hud.labelText = @"Loading";
	
    [hud show:YES];
}











-(void)showAlert:(NSString *)title message:(NSString *)currentMessage
{
    
    if ([currentMessage isKindOfClass:[NSArray class]]) {
        
        NSString * result = [[currentMessage valueForKey:@"id"] componentsJoinedByString:@","];
        currentMessage = result;
        
    }
    if (IS_IOS8) {
        UIAlertView *ErrorAlert = [[UIAlertView alloc]
                                   initWithTitle:title
                                   message:currentMessage
                                   delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = 0;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
        return;
    }

    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message: currentMessage
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [myAlertController addAction: ok];
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

-(void)showAlert:(NSString *)title message:(NSString *)currentMessage customTag:(int)currentTag
{
        UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:title
                                                             message:currentMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
        ErrorAlert.tag = currentTag;
        ErrorAlert.delegate = self;
        [ErrorAlert show];
  
    return;
   
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}




-(void)CallCreateNewChainView{
    UIViewController *desination = [self viewControllerFromStoryBoard:@"CreateVideo" withViewControllerName:@"SelectetChainTitleViewController"];
    
    
    [self.navigationController pushViewController:desination
                                         animated:YES];
    
}


-(AppDelegate *)sharedDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(NSString *)myCountryCode{
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *countryCode = [defaults objectForKey:@"phoneCode"];
    
    if (!countryCode) {
        return @"0";
        
    }
    return countryCode;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"Shaked");
        

    }
}


-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId{

 
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle: nil];
    return (UIViewController *)[mainStoryboard
                                instantiateViewControllerWithIdentifier: viewId];

}

-(void)addBackGroundViewForTableView:(UITableView *)tableView withText:(NSString *)text{
    UIView *currentView = [UIView new];
    
    currentView.backgroundColor = [UIColor clearColor];
    
    [currentView setFrame:CGRectMake(tableView.frame.origin.x,
                                     tableView.frame.origin.y,
                                     tableView.frame.size.width,
                                     tableView.frame.size.height)];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 30)];
    
    messageLabel.text = text;
    messageLabel.textColor = [UIColor blackColor];
    //messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [currentView addSubview:messageLabel];
    
    
    tableView.backgroundView = currentView;
    
    if ([text length] == 0) {
               tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}


+ (NSString *) makeMd5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


- (IBAction)btnBackTapped {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(int)groupId{
    

    if ([[self.userDefaults objectForKey:@"myProfileObject"] isKindOfClass:[NSArray class]]) {
        
        return [[[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"group_id"] intValue];
        
    }
    
    return [[[self.userDefaults objectForKey:@"myProfileObject"] objectForKey:@"group_id"] intValue];
    
}

-(NSString *)myJid{
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"id"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"id"];
    
}


-(NSString *)myName{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"name"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"name"];
    
}

-(NSString *)myEmail{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"email"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"email"];
    
}

-(NSString *)myPhoneNumber{
    
    
    if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
        return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"phone_number"];
    }
    return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"phone_number"];
    
}

-(NSString *)myProfileImageUrl{
    @try {


        if ([[self.userDefaults objectForKey:@"isFirstTimeSignUp"] isKindOfClass:[NSArray class]]) {
            return [[[self.userDefaults objectForKey:@"isFirstTimeSignUp"] firstObject] objectForKey:@"profile_image"];
        }
        return [[self.userDefaults objectForKey:@"isFirstTimeSignUp"] objectForKey:@"profile_image"];
    
        
    } @catch (NSException *exception) {
     
        return nil;
        
    }

}


-(NSDictionary *)completedAssetLink{
    
    return [self.userDefaults objectForKey:@"completedAssetLink"];;
    
}


-(void)connectionErrorDelegate{
    
    //[self.view makeToast:@"Unable to establish connection with the Server. Please check your internet connection and try again!"];
    
    
    for (UIView *allSubView in [self.view subviews]) {
        
        if ([allSubView isKindOfClass:[UIActivityIndicatorView class]]) {
            
            UIActivityIndicatorView *tmp = allSubView;
            
            [tmp stopAnimating];
            
        
        }
    }
    [self stopLoader];
    
}



-(RestCall *)serviceCallObject{
    
    if (!_serviceCallObject) {
        _serviceCallObject = [RestCall new];
        _serviceCallObject.delegate =self;
    }
    return _serviceCallObject;
}


-(void)slideUp:(int)scale{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = -scale;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}

-(void)slideBackToNormal{
    CGRect viewFrame;
    viewFrame=self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    viewFrame.origin.y = 0;
    self.view.frame=viewFrame;
    [UIView commitAnimations];
}


-(void)makeCallToNumber:(NSString *)number{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];;
}


-(void)callNotificationWithTitle:(NSString *)title withInformation:(NSString *)info
{
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:title
                                                   description:info
                                                          type:TWMessageBarMessageTypeInfo
                                               statusBarHidden:YES
                                                      callback:nil];
}








#pragma mark AAShareBubbles


-(BOOL)checkForAnonymous{
    
    if ([[self myJid] isEqualToString:@"anonymous"]) {
        
        return NO;
    }
    else
        return YES;
    
    return NO;
    
}




-(UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController
                                                              interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}



-(void)useMyCurrentLocationUpdated{
    
}





-(void)insertSpinnerOfStyle:(RTSpinKitViewStyle)style
            backgroundColor:(UIColor*)backgroundColor
                      label:(NSString *)labelString
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
     self.spinner = [[RTSpinKitView alloc] initWithStyle:style color:[UIColor whiteColor]];
    
    self.spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [self.spinner startAnimating];
    
    
     self.panel = [[UIView alloc] initWithFrame:CGRectOffset(self.view.bounds, 1.0, 1.0)];
    
    self.panel.backgroundColor = backgroundColor;
    
    [self.panel addSubview:self.spinner];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50.0, screenWidth, 30.0)];
    label.text = labelString;
    label.font = [UIFont systemFontOfSize:25.0];
    label.textColor = [UIColor whiteColor];
    
    if ([label respondsToSelector:@selector(tintColor)]) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        label.textAlignment = UITextAlignmentCenter;
#pragma GCC diagnostic pop
        label.backgroundColor = [UIColor clearColor];
    }
    
    [self.panel addSubview:label];
    [self.view addSubview:self.panel];
    

}


-(NSString *)myPhoneCode{
    
    return @"+1";
    
}


-(void)showLoader{
    @try {

      //  [[self insertSpinnerOfStyle:RTSpinKitViewStylePlane backgroundColor:[UIColor grayColor]] label:@"Test"];
        
        if ( self.spinner) {
            
            [self.panel setHidden:NO];
            [self.view bringSubviewToFront:self.panel];
            
        }
        else {
            
            [self insertSpinnerOfStyle:RTSpinKitViewStylePlane backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] label:@"Loading Data"];
            
        
            
        }

    } @catch (NSException *exception) {
     
        NSLog(@"");
        
    }
    
}

-(void)showMenuViewController{
    
    MenuViewController * menuViewController =
    (MenuViewController *)[self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"MenuViewController"];
   
    menuViewController.delegate = self;
    
    [self presentViewController:menuViewController animated:YES completion:^{
        
    }];
    
}
-(void)hideLoader{
    
    @try {

        [self.panel setHidden:YES];
        
        [self.view sendSubviewToBack:self.panel];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}

-(void)addSearchToTableView:(UITableView *)tableView isHiddenIneditally:(BOOL)isHidden{
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.delegate = self;
    
    
    UISearchController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                                             contentsController:self];
    
    searchController.delegate = self;
    
    if (!isHidden) {
        
        tableView.tableHeaderView = self.searchBar;
    }
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.isSearching = NO;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //isSearching = YES;
    
}


-(void)profileButtonTapped{
    
   
    
    [self showMyProfileView];
    
}
-(void)showMyProfileView{
    
    ProfileViewController *destination = [self viewControllerFromStoryBoard:@"Main" withViewControllerName:@"ProfileViewController"];
    
    [self.navigationController pushViewController:destination animated:YES];
    
}

-(UIToolbar *)makeToolCarWithWithSelectorWith:(UIBarButtonItem *)barButtonDone
{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,barButtonDone, nil]];
    _defaultFirstToolBar = toolbar;
    
    [toolbar sizeToFit];
    
    
    
    return toolbar;
    
}


- (void)btnPlayIntroVideoTapped:(NSString *)sender {
    
    NSString *introMediaUrl = sender;
    
    
    
    if(!introMediaUrl)
        return;
    
    NSURL *url;
        AVPlayer *player;
    if ([sender isKindOfClass:[AVURLAsset class]]) {
        //tmp
        
        AVURLAsset * tmp = sender;
        [tmp.URL path];
        url = [NSURL fileURLWithPath:[tmp.URL path]];
     
   
        player  = [AVPlayer playerWithURL:url];
        
    }
    else if ([sender contains:@"/var/mobile/"]){
        
        
        url = [NSURL fileURLWithPath:introMediaUrl];
        
        
        player  = [AVPlayer playerWithURL:url];
        
        
    }
    else{
        url=[[NSURL alloc] initWithString:introMediaUrl];
        player  = [AVPlayer playerWithURL:url];
        
    }


    
    _moviePlayer = [[AVPlayerViewController alloc] init];
    _moviePlayer.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoDidFinish:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_moviePlayer.player currentItem]];
    
    
    _moviePlayer.showsPlaybackControls = YES;
    

    

    _moviePlayer.player = player;

    [self presentViewController:_moviePlayer animated:YES completion:nil];

    [player play];
    
}

- (void)videoDidFinish:(id)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self hideLoader];
    
    //fade out / remove subview
}



-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng
{
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"+1234567890"];
    
    s = [s invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:s];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    else
        return YES;
}

- (BOOL)isAlphanumeric:(NSString *)string
{
    NSString *regex = @"[A-Z]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [test evaluateWithObject:string];
    
    return result;
    
}

-(NSString*)stringByCleaningPhoneNumber: (NSString*) countryPrefix{
    
    NSString *clean = [countryPrefix stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@" " withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"-" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"(" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@")" withString:@""];
    clean = [clean stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if(countryPrefix){
        NSString *totalPrefix = [NSString stringWithFormat:@"+%@", countryPrefix];
        if([clean hasPrefix:totalPrefix]){
            clean = [clean substringFromIndex:totalPrefix.length];
        }
    }
    return clean;
}

-(NSString *)converRawPhoneNumberToInternational:(NSString *)givenNumber currentCountryCode:(NSString *)countryCode
{
    NSString * currentString = [[givenNumber componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    
    @try {
        
        
        
        
        if ([currentString length] < 11) return currentString;
        
        if ([[currentString substringToIndex:1] isEqualToString:@"0"] || [[currentString substringToIndex:1] isEqualToString:@"+"])
        {
            
            if ([[currentString substringFromIndex:1] isEqualToString:@"0"]
                && [[currentString substringFromIndex:2] isEqualToString:@"0"])
            {
                
                NSLog(@"");
                
            }
            else if([[currentString substringToIndex:2] isEqualToString:@"00"])
            {
                currentString = [currentString stringByReplacingOccurrencesOfString:@"(" withString:@""];
                currentString =[currentString stringByReplacingOccurrencesOfString:@")" withString:@""];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                NSString *tmp = [currentString substringFromIndex:2];
                
                tmp = [@"+" stringByAppendingString:tmp];
                currentString = tmp;
                
                NSLog(@"");
                
            }
            
            else if([[currentString substringToIndex:1] isEqualToString:@"+"])
            {
                //currentString = [currentString substringFromIndex:1];
                //currentString = [@"+" stringByAppendingString:currentString];
                
            }
            else{
                currentString = [currentString substringFromIndex:1];
                if ([countryCode contains:@"+"]) {
                    
                    countryCode =   [countryCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
                }
                currentString = [[@"+" stringByAppendingString:countryCode]
                                 stringByAppendingString:currentString ];
                
            }
        }
        
        
        
        
        
        currentString = [self stringByCleaningPhoneNumber:currentString];
        
        
        return currentString;
        
    }
    
    @catch (NSException *exception) {
        
        return currentString;
        
    }
    
}

-(NSString *)contactsJSON{
    
    

    
    
    
    
    return @"";
    
}

-(void)showImageFromHttpUrl:(NSString *)urlToShow{
    
    [self showLoader];
    
    [FileManager loadImageFromurl:urlToShow
            withComplitionHandler:^(id tmp)
     {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             
             [self hideLoader];
             

                              JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
                 imageInfo.image = tmp;
             
             imageInfo.referenceRect = self.view.frame;
             
             imageInfo.referenceView = self.view;
             
             JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                                    initWithImageInfo:imageInfo
                                                    mode:JTSImageViewControllerMode_Image
                                                    backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
             [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
             
             
             

         });
     }
                   withFailHander:^(int tmp) {
                       
                   }];
    
    
}

-(void)callAlertViewControllerWithTitle:(NSString *)title withMessage:(NSString *)message withOkButtonTitle:(NSString *)okTitle withCancleTitle:(NSString *)cancleTitle withOKHandler:(void(^)(void))okHandler withCancelHandler:(void(^)(void))CancelHandler
{
    
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message:message
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:okTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [myAlertController dismissViewControllerAnimated:YES completion:^{
                                 
                             }];
                             
                             okHandler();
                             
                         }];
    
    [myAlertController addAction: ok];
    
    if ([cancleTitle length] > 0) {

        UIAlertAction* cancelAction = [UIAlertAction
                                       actionWithTitle:cancleTitle
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           
                                           [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                           
                                           
                                           CancelHandler();
                                           
                                       }];
        [myAlertController addAction: cancelAction];
    
        
    }
    
    //[myAlertController setBackgroundColor:[UIColor darkGrayColor]];

    
    //[[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];

    
    //alertContentView.backgroundColor = UIColor.blackColor()

    
//myAlertController
    
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio
{
    AVAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime duration = asset.duration;
    CGFloat durationInSeconds = duration.value / duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(durationInSeconds * ratio, (int)duration.value);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnail;
}



- (void)videoOutput
{
    // 1 - Early exit if there's no video file selected
    if (!self.videoAsset) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Load a Video Asset First"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    // 3 - Video track
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, self.videoAsset.duration)
                        ofTrack:[[self.videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    
    
    AVMutableCompositionTrack *audioTrack;
    
    audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                             preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,self.videoAsset.duration)
                        ofTrack:[[self.videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
    
    
    // 3.1 - Create AVMutableVideoCompositionInstruction
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, self.videoAsset.duration);
    
    // 3.2 - Create an AVMutableVideoCompositionLayerInstruction for the video track and fix the orientation.
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    AVAssetTrack *videoAssetTrack = [[self.videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    UIImageOrientation videoAssetOrientation_  = UIImageOrientationUp;
    BOOL isVideoAssetPortrait_  = NO;
    CGAffineTransform videoTransform = videoAssetTrack.preferredTransform;
    if (videoTransform.a == 0 && videoTransform.b == 1.0 && videoTransform.c == -1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ = UIImageOrientationRight;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 0 && videoTransform.b == -1.0 && videoTransform.c == 1.0 && videoTransform.d == 0) {
        videoAssetOrientation_ =  UIImageOrientationLeft;
        isVideoAssetPortrait_ = YES;
    }
    if (videoTransform.a == 1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == 1.0) {
        videoAssetOrientation_ =  UIImageOrientationUp;
    }
    if (videoTransform.a == -1.0 && videoTransform.b == 0 && videoTransform.c == 0 && videoTransform.d == -1.0) {
        videoAssetOrientation_ = UIImageOrientationDown;
    }
    [videolayerInstruction setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:0.0 atTime:self.videoAsset.duration];
    
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    CGSize naturalSize;
    if(isVideoAssetPortrait_){
        naturalSize = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    } else {
        naturalSize = videoAssetTrack.naturalSize;
    }
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    [self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize];
    
    // 4 - Get path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"FinalVideo-%d.mov",arc4random() % 1000]];
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
    // 5 - Create exporter
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.shouldOptimizeForNetworkUse = YES;
    exporter.videoComposition = mainCompositionInst;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exportDidFinish:exporter];
        });
    }];
}

- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size
{
    // 1 - Set up the text layer
    
    
    // 2 - The usual overlay
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    
    
    UIImage *animationImage =self.overLayImageUsing;
    
    CALayer *overlayLayer1 = [CALayer layer];
    [overlayLayer1 setContents:(id)[animationImage CGImage]];
    
    
    overlayLayer1.frame = CGRectMake(0, 0,
                                     self.overLayImageUsing.size.width,
                                     self.overLayImageUsing.size.height);
    [overlayLayer1 setMasksToBounds:YES];
    
    [parentLayer addSublayer:overlayLayer1];
    
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
}


-(UIColor *)transperancyColor{
    
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.90];
    
}


-(NSAttributedString *)requestText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"request"];
    id boldFontName = [UIFont fontWithName:FontToUseBold size:30];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:30];
    
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
    
    return attrString;
    
}



-(NSAttributedString *)reSearcherText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"researcher"];
    id boldFontName = [UIFont fontWithName:FontToUseBold size:32];
    id normalFont = [UIFont fontWithName:FontToUseRegular size:31];
    
    [attrString beginEditing];
    
    NSRange boldedRange = NSMakeRange(2, [attrString length] -3);
    NSRange normalRange2 = NSMakeRange(0, 2);
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    [attrString endEditing];
    
    return attrString;
    
}


-(UILabel *)navLabel{
    
         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
        return appDelegate.navBarTitle;
    
}
@end
