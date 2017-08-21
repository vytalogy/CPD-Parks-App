//
//  WarningLeaving.h
//  CDP
//
//  Created by Tauqeer Ahmed on 8/21/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarningLeaving : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnExit;

-(void)setupView;

@end
