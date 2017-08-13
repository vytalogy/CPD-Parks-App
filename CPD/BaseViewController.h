//
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Config.h"
#import "RestCall.h"
#import "Wrapper.h"
#import "SlideNavigationController.h"
#import "Validator.h"
#import "NSString+JS.h"
#import <CommonCrypto/CommonDigest.h>
#import "FileManager.h"
#import "NSDate+Utilities.h"
#import "TWMessageBarManager.h"
#import "NSString+HTML.h"
#import "ZFModalTransitionAnimator.h"
#import "CoreLocationController.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "UITextField+MyTextField.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DYAlertPickView.h"
#import "ESImageViewController.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "VideoMaker.h"
#import "Parks.h"
#import "Level.h"
#import "Question.h"
#import "Bonus.h"
#import "RTSpinKitView.h"
#import "FileManager.h"
#import "MenuViewController.h"
#import "UIView+MyUIView.h"
#import <CoreText/CoreText.h>




@import AVKit;
@class AVAssetExportSession;

@class AppDelegate;
@class AVMutableVideoComposition;

@interface BaseViewController : UIViewController<UITextFieldDelegate,SlideNavigationControllerDelegate,RestCallDelegates,UITextViewDelegate>
{

    float radius;
    float bubbleRadius;
}
@property (nonatomic,strong) UIImage *overLayImageUsing;
-(void)topImageViewTapped;
@property (nonatomic,strong) NSURL *videoUrlUploading;
@property (weak, nonatomic) IBOutlet UIView *viewTitleContainer;
-(void)showAlert:(NSString *)title message:(NSString *)currentMessage;
-(void)showAlert:(NSString *)title message:(NSString *)currentMessage customTag:(int)currentTag;
@property(nonatomic, strong) AVAsset *videoAsset;
-(void)stopLoader;
-(void)restartLaoder;
-(void)createNewLoaderForModal;
-(void)CallCreateNewChainView;


-(AppDelegate *)sharedDelegate;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSUserDefaults *userDefaults;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) NSString *salt;







-(NSString *)myJid;

-(NSString *)myCountryCode;

-(void)mainMenuButtonTapped;

+(NSString *)giveServiceSalt;
+ (NSString *) makeMd5:(NSString *) input;

-(UIViewController *)viewControllerFromStoryBoard:(NSString *)storyboardName withViewControllerName:(NSString *)viewId;


@property (nonatomic,strong) RestCall *serviceCallObject;
-(void)addTopBarButtonByCode;


-(void)slideUp:(int)scale;
-(void)slideBackToNormal;


-(void)makeCallToNumber:(NSString *)number;

-(void)callNotificationWithTitle:(NSString *)title withInformation:(NSString *)info;

-(void)setWhenDidFilesWereDeletedLastTime;

-(int)whenDidFilesWereDeletedLastTime;

@property (nonatomic, strong) NSMutableArray *contactList;

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

@property (nonatomic,strong) id objectSharing;

-(BOOL)checkForAnonymous;

@property (nonatomic,strong) UISearchBar *searchBar;

@property (strong, nonatomic) NSString *viewTitle;


@property (nonatomic,strong) NSString *countryCodeForFeeds;

@property (nonatomic, retain) CoreLocationController *locationController;

@property (nonatomic) BOOL isLocationErrorMessageSlidedUp;
- (BOOL) isInternetConnectionAvailable;



-(void)topBarButtonTapped;


@property (nonatomic,strong) UIButton *btnTopBarBUtton;



@property (nonatomic,strong) CLLocation * myCurrentLocation;

-(void)setMyMap;
- (void)openMapsWithDirectionsTo:(CLLocationCoordinate2D)to latitude:(double)latitude longitude:(double)longitude;

@property (nonatomic) BOOL doSlideUpForLocationError;
@property (nonatomic) BOOL doSlidUpForNoInternetError;
-(void)useMyCurrentLocationUpdated;


@property (nonatomic,strong) UIView *viewSorryMessage;


-(void)addBackGroundViewForTableView:(UITableView *)tableView withText:(NSString *)text;

-(NSString *)myPhoneCode;
-(void)hideLoader;

-(void)showLoader;
-(int)groupId;
-(void)addSearchToTableView:(UITableView *)tableView isHiddenIneditally:(BOOL)isHidden;

@property (nonatomic,strong) NSMutableArray *filteredList;

@property (nonatomic) BOOL isSearching;

-(UIToolbar *)makeToolCarWithWithSelectorWith:(UIBarButtonItem *)barButtonDone;
@property (nonatomic,strong) UIToolbar *defaultFirstToolBar;

@property (nonatomic,strong) NSString *myName;
@property (nonatomic,strong) NSString *myEmail;

@property (nonatomic,strong) NSString *myPhoneNumber;

@property (nonatomic,strong) NSString *myProfileImageUrl;

@property (nonatomic, strong) AVPlayerViewController *moviePlayer;

- (void)btnPlayIntroVideoTapped:(NSString *)sender;
- (BOOL)isAlphanumeric:(NSString *)string;

-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng;
@property (nonatomic,strong) NSMutableArray *allPhones;
@property (nonatomic,strong) NSMutableArray *allEmail;
-(NSString*)stringByCleaningPhoneNumber: (NSString*) countryPrefix;

-(NSString *)converRawPhoneNumberToInternational:(NSString *)givenNumber currentCountryCode:(NSString *)countryCode;

-(NSString *)contactsJSON;


@property (nonatomic,strong) NSString *commaSeperatedEmail;
@property (nonatomic,strong) NSString *commaSeperatedPhone;

-(void)showImageFromHttpUrl:(NSString *)urlToShow;

-(void)callAlertViewControllerWithTitle:(NSString *)title withMessage:(NSString *)message withOkButtonTitle:(NSString *)okTitle withCancleTitle:(NSString *)cancleTitle withOKHandler:(void(^)(void))okHandler withCancelHandler:(void(^)(void))CancelHandler;

@property (nonatomic,strong) NSDictionary *completedAssetLink;
- (UIImage*)previewFromFileAtPath:(NSString*)path ratio:(CGFloat)ratio;

- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size;

- (void)videoOutput;

- (void)exportDidFinish:(AVAssetExportSession*)session;
-(void)insertSpinnerOfStyle:(RTSpinKitViewStyle)style
            backgroundColor:(UIColor*)backgroundColor
                      label:(NSString *)labelString;


@property (nonatomic,strong) RTSpinKitView *spinner;

@property (nonatomic,strong) UIView *panel;
-(void)showMenuViewController;
-(void)showMyProfileView;
-(UIColor *)transperancyColor;

@end
