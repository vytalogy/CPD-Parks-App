//
//  Question.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/29/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "Question.h"
#import "RestCall.h"
#import "Config.h"
#import "DateFormatter.h"
#import "NSString+JS.h"

@implementation Question

/*
 
 */

+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray{
    
    NSMutableArray *tmpResult =[NSMutableArray new];
    
    
    
    for (id currentItem in sourceArray)
    {
        
        [tmpResult addObject:[self parseInvolvedChains:currentItem]];
        
        
        
    }
    
    return tmpResult;
    
}

+(Question *)parseInvolvedChains:(NSDictionary *)sourceItem
{
    
    Question *tmpResult = [Question new];
    
    tmpResult.questionId =
    [[sourceItem objectForKey:@"ID"] intValue];
    
    tmpResult.question =
    [sourceItem objectForKey:@"Question"];
    tmpResult.imageURL =
    [sourceItem objectForKey:@"Image"];
    
    
    tmpResult.possiblePoints =
    [[sourceItem objectForKey:@"Point"] intValue];
    
    tmpResult.hint =
    [sourceItem objectForKey:@"Hint"];
    
    tmpResult.bonusId =
    [[sourceItem objectForKey:@"BonusID"] intValue];
    
    tmpResult.successImageUrl =
    [sourceItem objectForKey:@"SuccessImage"];
    
    
    tmpResult.expTitle =
    [sourceItem objectForKey:@"Exp_Title"];
    
    tmpResult.expDesc =
    [sourceItem objectForKey:@"Exp_Desc"];
    
    
  
    
    return tmpResult;
    
}


+(void)callQuestionsFromLevelId:(int)levelId
                     withParkId:(int)parkId
              ComplitionHandler:(void(^)(id result))completionHandler
                      withFailueHandler:(void(^)(void))failureHandler
{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *currentLevelQuestions = [NSString stringWithFormat:@"QuestionLevel/%d/%d",parkId,levelId];
    NSString *bonusItemName = [NSString stringWithFormat:@"Bonus/%d/%d",parkId,levelId];
    
    id dataAraay = [userDefaults objectForKey:currentLevelQuestions];
    
    
    if (dataAraay) {
        
        
        id parsedObject = [self parseMyInvolvedChainsFrom:dataAraay];
        
        completionHandler(parsedObject);
        
        
        return;
    }
    
    
    
   
    [RestCall callWebServiceWithTheseParams:nil
                      withSignatureSequence:nil
                                 urlCalling:
     [baseServiceUrl stringByAppendingString: [NSString stringWithFormat:@"Getquestions/%d/%d",parkId,levelId]]
                              isPostService:NO
                      withComplitionHandler:^(id result) {
                          
                          @try {
                              id message = [result objectForKey:@"message"];
                              
                              if ([[message objectForKey:@"status"] isEqualToString:@"Success"]) {
                                  
                                  id data = [message objectForKey:@"Questions"];
                                  
                                  id bonus = [message objectForKey:@"Bonus"];
                                  
                                  [userDefaults setObject:data forKey:currentLevelQuestions];
                                  
                                  
                                  if (bonus) {
                                      
                                      [userDefaults setObject:bonus forKey:bonusItemName];
                                      
                                      //bonusItemName
                                      
                                  }
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
