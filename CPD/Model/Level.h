//
//  Level.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

/*
 ID: 1,
 Name: "Junior Recruit",
 Rules: "Benefits of the proposed project would include restoring native wetlands and creating a complex ecosystem to benefit fish, amphibians, reptiles, mammals, and migratory birds"
 */


@property (nonatomic) int itemId;
@property (nonatomic,strong) NSString *levelName;
@property (nonatomic,strong) NSString *levelRules;

+(void)callGetAllLevelComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;

@end
