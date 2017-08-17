//
//  Rules.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/17/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "Rules.h"
#import "RestCall.h"
#import "Config.h"
#import "DateFormatter.h"
#import "NSString+JS.h"

@implementation Rules

+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray{
    
    NSMutableArray *tmpResult =[NSMutableArray new];
    
    
    
    for (id currentItem in sourceArray)
    {
        
        [tmpResult addObject:[self parseInvolvedChains:currentItem]];
        
        
        
    }
    
    return tmpResult;
    
}
+(Rules *)parseInvolvedChains:(NSDictionary *)sourceItem
{
    
    Rules *tmpResult = [Rules new];
    
    /*
    tmpResult.questionId =
    [[sourceItem objectForKey:@"ID"] intValue];
    
    tmpResult.question =
    [sourceItem objectForKey:@"Question"];
    
    tmpResult.answer =
    [sourceItem objectForKey:@"Answer"];
    
    tmpResult.questionId =
    [[sourceItem objectForKey:@"QuestionID"] intValue];
    
    
    */
    
    return tmpResult;
    
}



+(void)callRulesWithComplitionHandler:(void(^)(id result))completionHandler
              withFailueHandler:(void(^)(void))failureHandler
{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    

    NSString *bonusItemName = [NSString stringWithFormat:@"AppRules"];
    
    id dataAraay = [userDefaults objectForKey:bonusItemName];
    
    
    if (dataAraay) {
        
        
        
        completionHandler(dataAraay);
        
        
        return;
    }
    
    
    
    
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString: [NSString stringWithFormat:@"GetRules"]]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              id message = [result objectForKey:@"message"];
                              
                              if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  

                                  id data = [message objectForKey:@"Data"];
                                  
                                  id finalString = [[data firstObject] objectForKey:@"Description"];
                                  
                                  
                                  [userDefaults setObject:finalString forKey:@"AppRules"];
                                  
                                  /*
                                   
                                   
                                   
                                   */
                                  

                                      [userDefaults setObject:finalString forKey:bonusItemName];
                                      
                                      //bonusItemName
                                      
                                  
                                  //Bonus
                                  
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
