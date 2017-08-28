//
//  MapView.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MapView.h"

@interface MapView()

@property (nonatomic) NSString * hegwishMapUrl;
@property (nonatomic) NSString * bigMapUrl;
@property (nonatomic) NSString * indianMapUrl;


@property (nonatomic) int currentMapShowing;

@end

@implementation MapView


-(NSString *)hegwishMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.655496,%%20-87.564370&zoom=15&size=640x640"];
    
    
}

-(NSString *)bigMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.690329,-87.5705071&zoom=15&size=640x640"];
    
    
}

-(NSString *)indianMapUrl{
    
    
    
    return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=41.6800257,-87.5606165&zoom=15&size=640x640"];
    
    
}


-(void)tapDetected{
    NSLog(@"single Tap on imageview");
    
    if (_currentMapShowing == 0) {
        

        
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
    
    else if (_currentMapShowing == 1) {
        
        
        
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
    else if (_currentMapShowing == 2) {
        
        
        
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
    
    
}

-(void)setUpView{
    
    
    [self.mapContainer addShadow];
    
    self.lblText.font = MapRegularTextFont;
    
    
    self.lblAreYouSure.font = MapBoldTextFont;
    
    
    self.btnExit.titleLabel.font = QuestionViewBottomButtonFonts;
    

    
    self.btnExit.backgroundColor = LightGreenTextColor;
    
    _btnExit.layer.cornerRadius = 18;
    
    
    ;
    
    self.mapWidth.constant = [UIScreen mainScreen].bounds.size.width;
    self.mapHeight.constant = [UIScreen mainScreen].bounds.size.width;;
    
    
    
    [FileManager loadProfileImage:self.mapImageView url:self.hegwishMapUrl];
    
    
    
    //
    
    
    
    
    // 1  https://maps.googleapis.com/maps/api/staticmap?center=41.655496,%20-87.564370&zoom=15&size=600x400
    
    
    //
    
    //3
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.mapImageView setUserInteractionEnabled:YES];
    [self.mapImageView addGestureRecognizer:singleTap];
    

    
}
- (IBAction)segmentSelected:(UISegmentedControl *)sender {


    
    if (sender.selectedSegmentIndex == 0) {
        
        [FileManager loadProfileImage:self.mapImageView url:self.hegwishMapUrl];
        
        self.currentMapShowing = 0;
    }
    else
        if (sender.selectedSegmentIndex == 1) {
            
            [FileManager loadProfileImage:self.mapImageView url:self.bigMapUrl];
        self.currentMapShowing = 1;
            
        }
        else
            if (sender.selectedSegmentIndex == 2) {
                
                [FileManager loadProfileImage:self.mapImageView url:self.indianMapUrl];
            
                        self.currentMapShowing = 2;
            }
    
}

@end
