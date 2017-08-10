//
//  Bonus.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/30/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bonus : NSObject


+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray;

@property (nonatomic,strong) NSString *answer;

@property (nonatomic) int itemId;

@property (nonatomic,strong) NSString * question;

@property (nonatomic) int questionId;

@end
