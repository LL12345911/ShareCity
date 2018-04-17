//
//  Addition.m
//  AirCnCWallent
//
//  Created by Mars on 2018/4/4.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import "Addition.h"

@implementation Addition


//两个大数相加算法
+(NSString *)addTwoNumberWithOneNumStr:(NSString *)one anotherNumStr:(NSString *)another
{
    int i = 0;
    int j = 0;
    int maxLength = 0;
    int sum = 0;
    int overflow = 0;
    int carryBit = 0;
    NSString *temp1 = @"";
    NSString *temp2 = @"";
    NSString *sums = @"";
    NSString *tempSum = @"";
    int length1 = (int)one.length;
    int length2 = (int)another.length;
    //1.反转字符串
    for (i = length1 - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        temp1 = [temp1 stringByAppendingString:[one substringWithRange:range]];
        NSLog(@"%@",temp1);
    }
    for (j = length2 - 1; j >= 0; j--) {
        NSRange range = NSMakeRange(j, 1);
        temp2 = [temp2 stringByAppendingString:[another substringWithRange:range]];
        NSLog(@"%@",temp2);
    }
    
    //2.补全缺少位数为0
    maxLength = length1 > length2 ? length1 : length2;
    if (maxLength == length1) {
        for (i = length2; i < length1; i++) {
            temp2 = [temp2 stringByAppendingString:@"0"];
            NSLog(@"i = %d --%@",i,temp2);
        }
    }else{
        for (j = length1; j < length2; j++) {
            temp1 = [temp1 stringByAppendingString:@"0"];
            NSLog(@"j = %d --%@",j,temp1);
        }
    }
    //3.取数做加法
    for (i = 0; i < maxLength; i++) {
        NSRange range = NSMakeRange(i, 1);
        int a = [temp1 substringWithRange:range].intValue;
        int b = [temp2 substringWithRange:range].intValue;
        sum = a + b + carryBit;
        if (sum > 9) {
            if (i == maxLength -1) {
                overflow = 1;
            }
            carryBit = 1;
            sum -= 10;
        }else{
            carryBit = 0;
        }
        tempSum = [tempSum stringByAppendingString:[NSString stringWithFormat:@"%d",sum]];
    }
    if (overflow == 1) {
        tempSum = [tempSum stringByAppendingString:@"1"];
    }
    int sumlength = (int)tempSum.length;
    for (i = sumlength - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        sums = [sums stringByAppendingString:[tempSum substringWithRange:range]];
    }
    NSLog(@"sums = %@",sums);
    return sums;
}



+ (NSString *)additionOfString:(NSString *)strOne AndString:(NSString *)strTwo{
    
    
    
    NSMutableString *One = [NSMutableString stringWithFormat:@"%@",strOne ];
    
    NSMutableString *Two = [NSMutableString stringWithFormat:@"%@",strTwo ];
    
    
    
    if (One.length > Two.length) {
        
        NSInteger t = One.length - Two.length;
        
        for (NSInteger i = 0;i < t;i++) {
            
            [Two insertString:[NSString stringWithFormat:@"0"] atIndex:0];
            
        }
        
        int jin = 0;
        
        NSMutableString *strJ = [[NSMutableString alloc]init];
        
        for (NSInteger i = One.length -1 ; i >= 0 ;i--) {
            
            unichar onenum = [One characterAtIndex:i];
            
            unichar twonum = [Two characterAtIndex:i];
            
            int onum = [[NSString stringWithFormat:@"%c",onenum] intValue];
            
            int tnum = [[NSString stringWithFormat:@"%c",twonum] intValue];
            
            int c = onum + tnum +jin;
            
            int z = c%10;
            
            jin = c/10;
            
            if (i !=0 ) {
                
                [strJ appendFormat:@"%d",z];
                
            }else{
                
                [strJ appendFormat:@"%d",c%10];
                
                if (c/10 != 0) {
                    
                    [strJ appendFormat:@"%d",c/10];
                    
                }
                
            }
            
        }
        
        NSMutableString *zheng = [[NSMutableString alloc]init];
        
        for (NSInteger i = strJ.length-1; i>=0;i--) {
            
            unichar k = [strJ characterAtIndex:i];
            
            [zheng appendFormat:@"%c",k];
            
        }
        
        return zheng;
        
    }else if(One.length < Two.length){
        
        NSInteger t = Two.length - One.length;
        
        for (NSInteger i = 0;i < t;i++) {
            
            [One insertString:[NSString stringWithFormat:@"0"] atIndex:0];
            
        }
        
        int jin = 0;
        
        NSMutableString *strJ = [[NSMutableString alloc]init];
        
        for (NSInteger i = Two.length - 1; i >= 0 ;i--) {
            
            unichar onenum = [One characterAtIndex:i];
            
            unichar twonum = [Two characterAtIndex:i];
            
            int onum = [[NSString stringWithFormat:@"%c",onenum] intValue];
            
            int tnum = [[NSString stringWithFormat:@"%c",twonum] intValue];
            
            int c = onum + tnum +jin;
            
            int z = c%10;
            
            jin = c/10;
            
            if (i !=0 ) {
                
                [strJ appendFormat:@"%d",z];
                
            }else{
                
                [strJ appendFormat:@"%d",c%10];
                
                if (c/10 != 0) {
                    
                    [strJ appendFormat:@"%d",c/10];
                    
                }
                
            }
            
        }
        
        NSMutableString *zheng = [[NSMutableString alloc]init];
        
        for (NSInteger i = strJ.length-1; i>=0;i--) {
            
            unichar k = [strJ characterAtIndex:i];
            
            [zheng appendFormat:@"%c",k];
            
        }
        
        return zheng;
        
    }else if(One.length == Two.length){
        
        int jin = 0;
        
        NSMutableString *strJ = [[NSMutableString alloc]init];
        
        for (NSInteger i = One.length - 1; i >= 0 ;i--) {
            
            unichar onenum = [One characterAtIndex:i];
            
            unichar twonum = [Two characterAtIndex:i];
            
            int onum = [[NSString stringWithFormat:@"%c",onenum] intValue];
            
            int tnum = [[NSString stringWithFormat:@"%c",twonum] intValue];
            
            int c = onum + tnum +jin;
            
            int z = c%10;
            
            jin = c/10;
            
            if (i !=0 ) {
                
                [strJ appendFormat:@"%d",z];
                
            }else{
                
                [strJ appendFormat:@"%d",c%10];
                
                if (c/10 != 0) {
                    
                    [strJ appendFormat:@"%d",c/10];
                    
                }
            }
        }
        
        NSMutableString *zheng = [[NSMutableString alloc]init];
        
        for (NSInteger i = strJ.length-1; i>=0;i--) {
            
            unichar k = [strJ characterAtIndex:i];
            
            [zheng appendFormat:@"%c",k];
            
        }
        
        return zheng;
        
    }
    
    
    
    return @"您的输入有误！";
    
}







@end
