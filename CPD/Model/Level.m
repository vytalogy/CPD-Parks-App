//
//  Level.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "Level.h"
#import "RestCall.h"
#import "Config.h"
#import "DateFormatter.h"
#import "NSString+JS.h"


@implementation Level


+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray{
    
    NSMutableArray *tmpResult =[NSMutableArray new];
    
    
    
    for (id currentItem in sourceArray)
    {
        
        [tmpResult addObject:[self parseInvolvedChains:currentItem]];
        
        
        
    }
    
    return tmpResult;
    
}

+(Level *)parseInvolvedChains:(NSDictionary *)sourceItem
{
    
    Level *tmpResult = [Level new];
    
    
    tmpResult.levelName =
    [sourceItem objectForKey:@"Name"];
    
    tmpResult.itemId =
    [[sourceItem objectForKey:@"ID"] intValue];
    
    tmpResult.levelRules =
    [sourceItem objectForKey:@"Rules"];
    
    
    
    
    
    
    
    
    
    return tmpResult;
    
}





+(void)callGetAllLevelComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    id dataAraay = [userDefaults objectForKey:@"allLevels"];;
    
    
    if (dataAraay) {
        
        
        id parsedObject = [self parseMyInvolvedChainsFrom:dataAraay];
        
        completionHandler(parsedObject);
        
        
        return;
    }
    
    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString:@"Getlevels"]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              id message = [result objectForKey:@"message"];
                              
                              if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  id data = [message objectForKey:@"Data"];
                                  
                                  
                                  [userDefaults setObject:data forKey:@"allLevels"];
                                  
                                  
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

@end
