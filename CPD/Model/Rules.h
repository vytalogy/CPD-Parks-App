//
//  Rules.h
//  CDP
//
//  Created by Tauqeer Ahmed on 8/17/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rules : NSObject

+(void)callRulesWithComplitionHandler:(void(^)(id result))completionHandler
                    withFailueHandler:(void(^)(void))failureHandler;

@end
