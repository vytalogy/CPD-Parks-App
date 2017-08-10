//
//  Parks.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Parks : NSObject

/*

 : "Hegewisch Marsh is a ~131 acre natural area located on the south side of Chicago, with about 119 acres recommended for restoration. The site is bounded to the north by 130th Street, to the east by Torrence Avenue, to the south by USACE property"
 */


@property (nonatomic) int itemId;
@property (nonatomic,strong) NSString *parkName;
@property (nonatomic,strong) NSString *parkDescription;

+(void)callGetAllParksComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler;


@end
