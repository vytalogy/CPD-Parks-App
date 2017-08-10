//
//  Bonus.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/30/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "Bonus.h"

@implementation Bonus

+(NSArray *)parseMyInvolvedChainsFrom:(NSArray *)sourceArray{
    
    NSMutableArray *tmpResult =[NSMutableArray new];
    
    
    
    for (id currentItem in sourceArray)
    {
        
        [tmpResult addObject:[self parseInvolvedChains:currentItem]];
        
        
        
    }
    
    return tmpResult;
    
}

+(Bonus *)parseInvolvedChains:(NSDictionary *)sourceItem
{
    
    Bonus *tmpResult = [Bonus new];
    
    tmpResult.questionId =
    [[sourceItem objectForKey:@"ID"] intValue];
    
    tmpResult.question =
    [sourceItem objectForKey:@"Question"];
    
    tmpResult.answer =
    [sourceItem objectForKey:@"Answer"];
    
    tmpResult.questionId =
    [[sourceItem objectForKey:@"QuestionID"] intValue];
    
    
    
    return tmpResult;
    
}


@end
