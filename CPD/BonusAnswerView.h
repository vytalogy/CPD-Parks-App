//
//  BonusAnswerView.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/24/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BonusAnswerView : UIView

-(void)setupView;
@property (nonatomic,strong) NSMutableArray *items;

@property (weak, nonatomic) IBOutlet UILabel *lblBonusQuestion;

@end
