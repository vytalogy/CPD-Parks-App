//
//  Question.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic) int questionId;
@property (nonatomic,strong) NSString *question;
@property (nonatomic,strong) NSString *imageURL;

@property (nonatomic) int possiblePoints;

@property (nonatomic,strong) NSString * hint;

@property (nonatomic) int bonusId;


@property (nonatomic,strong) NSString *successImageUrl;

@property (nonatomic,strong) NSString *expTitle;

@property (nonatomic,strong) NSString *expDesc;



+(void)callQuestionsFromLevelId:(int)levelId
                     withCityId:(int)cityId
              ComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;

+(void)callQuestionsFromLevelId:(int)levelId
                     withParkId:(int)parkId
              ComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler;


@end
