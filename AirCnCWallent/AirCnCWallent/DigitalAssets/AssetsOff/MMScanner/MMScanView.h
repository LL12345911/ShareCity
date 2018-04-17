//
//  MMScanView.h
//  AirCnCWallent
//
//  Created by Mars on 2018/4/9.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MMScanTypeQrCode,
    MMScanTypeBarCode,
    MMScanTypeAll,
} MMScanType;

@interface MMScanView : UIView

-(id)initWithFrame:(CGRect)frame style:(NSString *)style;

- (void)stopAnimating;

@property (nonatomic, assign) MMScanType scanType;

@end
