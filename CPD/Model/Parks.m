//
//  Parks.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "Parks.h"
#import "RestCall.h"
#import "Config.h"
#import "DateFormatter.h"
#import "NSString+JS.h"

@implementation Parks



+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray{
    
    NSMutableArray *tmpResult =[NSMutableArray new];
    
    
    
    for (id currentItem in sourceArray)
    {
        
        [tmpResult addObject:[self parseInvolvedChains:currentItem]];
        
        NSLog(@"");
        
        
    }
    
    return tmpResult;
    
}

+(Parks *)parseInvolvedChains:(NSDictionary *)sourceItem
{
    
    Parks *tmpResult = [Parks new];
    
    
    tmpResult.parkName =
    [sourceItem objectForKey:@"Name"];
    
    tmpResult.itemId =
    [[sourceItem objectForKey:@"ID"] intValue];
    
    tmpResult.parkDescription =
    [sourceItem objectForKey:@"Description"];
    
    

    
    
  
    

    
    return tmpResult;
    
}



+(void)callGetAllParksComplitionHandler:(void(^)(id result))completionHandler
                           withFailueHandler:(void(^)(void))failureHandler
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    id dataAraay = [userDefaults objectForKey:@"parkObjects"];;
    
    
    if (dataAraay) {
        
        
        id parsedObject = [self parseMyInvolvedChainsFrom:dataAraay];
        
        completionHandler(parsedObject);
        
        
        return;
    }

    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"Getparks"]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              id message = [result objectForKey:@"message"];
                              
                              if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  id data = [message objectForKey:@"Data"];
                                  

                                  [userDefaults setObject:data forKey:@"parkObjects"];
                                  
                                  
                                  id parsedObject = [self parseMyInvolvedChainsFrom:data];
                                  
                                  completionHandler(parsedObject);
                                  
                              }
                              
                              else{
                                  
                                  failureHandler();
                              }
                              
                              
                              
                              
                          }
                          @catch (NSException *exception) {
                              
                              failureHandler();
                              
                          }
                          
                          
                      } failureComlitionHandler:^{
                          
                          failureHandler();
                          
                      }];
    
    
}


/*
 ID: 1,
 Name: "Hegewisch Marsh",
 Description: "Hegewisch Marsh is a ~131 acre natural area located on the south side of Chicago, with about 119 acres recommended for restoration. The site is bounded to the north by 130th Street, to the east by Torrence Avenue, to the south by USACE property"
 */

//



@end
