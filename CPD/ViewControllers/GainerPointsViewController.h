//
//  GainerPointsViewController.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/27/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GainerPointsViewController : BaseViewController

@property (nonatomic) int scoredPoints;

@property (nonatomic,strong) Level *level;

@property (nonatomic,strong) Parks *currentPark
;

@end
