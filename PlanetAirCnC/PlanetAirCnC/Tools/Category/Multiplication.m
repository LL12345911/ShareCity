//
//  Multiplication.m
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/4.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "Multiplication.h"

@implementation Multiplication


+(NSString *)MulOfOneString:(NSString *)strOne AndString:(NSString *)strTwo{
    
    
    
    NSString *a = [NSString stringWithFormat:@"%lu",(unsigned long)strOne.length];
    
    NSString *b = [NSString stringWithFormat:@"%lu",(unsigned long)strTwo.length];
    
    int oneLength = [a intValue];
    
    int twoLength = [b intValue];
    
    NSMutableArray *arrOne = [[NSMutableArray alloc]init];
    
    NSMutableArray *arrTwo = [[NSMutableArray alloc]init];
    
    for (int i = 0;i < oneLength;i++) {
        
        unichar c = [strOne characterAtIndex:i];
        
        NSString *c1 = [NSString stringWithFormat:@"%c",c];
        
        [arrOne addObject:c1];
        
    }
    
    for (int i = 0;i < twoLength;i++) {
        
        unichar c = [strTwo characterAtIndex:i];
        
        NSString *c1 = [NSString stringWithFormat:@"%c",c];
        
        [arrTwo addObject:c1];
        
    }
    
    NSMutableArray *arrShi = [[NSMutableArray alloc]init];
    
    if (oneLength > twoLength) {
        
        for (int i = twoLength - 1 ;i >= 0;i--) {
            
            NSMutableString *strJ = [[NSMutableString alloc]init];
            
            int jin = 0;
            
            int btwo = [arrTwo[i] intValue];
            
            for (int j = oneLength - 1; j >= 0;j--) {
                
                int aone = [arrOne[j] intValue];
                
                int c = aone * btwo + jin;
                
                int z = c%10;
                
                jin = c/10;
                
                if (j != 0) {
                    
                    [strJ appendFormat:@"%d",z];
                    
                }else{
                    
                    [strJ appendFormat:@"%d",c%10];
                    
                    if (c/10!=0) {
                        
                        [strJ appendFormat:@"%d",c/10];
                        
                    }
                    
                }
                
            }
            
            NSMutableString *zheng = [[NSMutableString alloc]init];
            
            for (NSInteger i = strJ.length-1 ;i>=0;i--) {
                
                unichar s = [strJ characterAtIndex:i];
                
                [zheng appendFormat:@"%c",s];
                
            }
            
            [arrShi addObject:zheng];
            
        }
        
    }else if(oneLength < twoLength){
        
        for (int i = oneLength - 1 ;i >= 0;i--) {
            
            NSMutableString *strJ = [[NSMutableString alloc]init];int jin = 0;
            
            int aone = [arrOne[i] intValue];
            
            for (int j = twoLength - 1; j >= 0;j--) {
                
                int btwo = [arrTwo[j] intValue];
                
                int c = aone * btwo + jin;
                
                int z = c%10;
                
                jin = c/10;
                
                if (j != 0) {
                    
                    [strJ appendFormat:@"%d",z];
                    
                }else{
                    
                    [strJ appendFormat:@"%d",c%10];
                    
                    if (c/10!=0) {
                        
                        [strJ appendFormat:@"%d",c/10];
                        
                    }                     }
                
            }
            
            NSMutableString *zheng = [[NSMutableString alloc]init];
            
            for (NSInteger i = strJ.length-1 ;i>=0;i--) {
                
                unichar s = [strJ characterAtIndex:i];
                
                [zheng appendFormat:@"%c",s];
                
            }
            
            [arrShi addObject:zheng];
            
        }
        
    }else if (oneLength == twoLength){
        
        for (int i = oneLength - 1 ;i >= 0;i--) {
            
            NSMutableString *strJ = [[NSMutableString alloc]init];int jin = 0;
            
            int aone = [arrOne[i] intValue];
            
            for (int j = twoLength - 1; j >= 0;j--) {
                
                int btwo = [arrTwo[j] intValue];
                
                int c = aone * btwo + jin;
                
                int z = c%10;
                
                jin = c/10;
                
                if (j != 0) {
                    
                    [strJ appendFormat:@"%d",z];
                    
                }else{
                    
                    [strJ appendFormat:@"%d",c%10];
                    
                    if (c/10!=0) {
                        
                        [strJ appendFormat:@"%d",c/10];
                        
                    }
                    
                }
                
            }
            
            NSMutableString *zheng = [[NSMutableString alloc]init];
            
            for (NSInteger i = strJ.length-1 ;i>=0;i--) {
                
                unichar s = [strJ characterAtIndex:i];
                
                [zheng appendFormat:@"%c",s];
                
            }
            
            [arrShi addObject:zheng];
            
        }
        
    }
    
    NSMutableArray *arrBF = [[NSMutableArray alloc]init];
    
    if (arrShi.count == 1) {
        
        NSString *res = arrShi[0];
        
        return res;
        
    }else{
        
        for (int i = 0;i<arrShi.count;i++) {
            
            NSMutableString *str0 = arrShi[i];
            
            for (int j = 1;j<=i;j++) {
                
                [str0 appendFormat:@"0"];
                
            }
            
            arrBF[i] = str0;
            
        }
        
        for (int i =1;i<arrBF.count;i++) {
            
            int J = 0;
            
            NSMutableString *strConst = [[NSMutableString alloc]init];
            
            NSString *strC = arrBF[i-1];
            
            NSString *strB = arrBF[i];
            
            if (strC.length == strB.length) {
                
                for (NSInteger j = strB.length-1 ;j >= 0;j--) {
                    
                    unichar b = [strB characterAtIndex:j];
                    
                    unichar c = [strC characterAtIndex:j];
                    
                    int B = [[NSString stringWithFormat:@"%c",b] intValue];
                    
                    int C = [[NSString stringWithFormat:@"%c",c] intValue];
                    
                    int counst = B + C + J;
                    
                    int z = counst %10;
                    
                    J = counst /10;
                    
                    if (j != 0) {
                        
                        [strConst appendFormat:@"%d",z];
                        
                    }else{
                        
                        [strConst appendFormat:@"%d",counst %10];
                        
                        if (counst /10!=0) {
                            
                            [strConst appendFormat:@"%d",counst /10];
                            
                        }
                        
                    }
                    
                }
                
                NSMutableString *Lin = [[NSMutableString alloc]init];
                
                for (NSInteger i = strConst.length-1 ;i>=0;i--) {
                    
                    unichar s = [strConst characterAtIndex:i];
                    
                    [Lin appendFormat:@"%c",s];
                    
                }
                
                arrBF[i] = Lin;
                
            }else{
                
                NSUInteger a = strC.length;
                
                for (NSInteger j = strB.length-1 ;j >= 0;j--) {
                    
                    unichar b = [strB characterAtIndex:j];
                    
                    unichar c = [strC characterAtIndex:a-1];
                    
                    int B = [[NSString stringWithFormat:@"%c",b] intValue];
                    
                    int C = [[NSString stringWithFormat:@"%c",c] intValue];
                    
                    a--;
                    
                    int counst = B + C + J;
                    
                    int z = counst %10;
                    
                    J = counst /10;
                    
                    if (j != 0) {
                        
                        [strConst appendFormat:@"%d",z];
                        
                    }else{
                        
                        [strConst appendFormat:@"%d",counst %10];
                        
                        if (counst /10!=0) {
                            
                            [strConst appendFormat:@"%d",counst /10];
                            
                        }
                        
                    }
                    
                }
                
                NSMutableString *Lin = [[NSMutableString alloc]init];
                
                for (NSInteger i = strConst.length-1 ;i>=0;i--) {
                    
                    unichar s = [strConst characterAtIndex:i];
                    
                    [Lin appendFormat:@"%c",s];
                    
                }
                
                arrBF[i] = Lin;
                
            }
            
        }
        
        NSString *res = arrBF[arrBF.count-1];
        
        return res;
        
    }
    
    return @"输入有误";
    
}


@end
