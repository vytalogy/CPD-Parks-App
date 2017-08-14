//
//  MapView.h
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
-(void)setUpView;


@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UILabel *lblAreYouSure;

@property (weak, nonatomic) IBOutlet UIButton *btnExit;

@end
