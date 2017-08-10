//
//  VideoMaker.h
//  Filmer
//
//  Created by Tauqeer Ahmed on 26/05/2016.
//  Copyright © 2016 Plego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoMaker : NSObject

+ (void) mergeTwoVideosWithFirstFileFromArray:(NSArray *)soureURLs withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler;

@end
