//
//  PayPopupView.h
//  PlanetAirCnC
//
//  Created by Mars on 2018/4/11.
//  Copyright © 2018年 AirCnC车去车来. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayPopupViewDelegate <NSObject>

- (void)didClickFinishPasswordButton;

- (void)didPasswordInputFinished:(NSString *)password;

@end

@interface PayPopupView : UIView

@property (nonatomic, weak) id <PayPopupViewDelegate> delegate;

- (void)showPayPopView;
- (void)hidePayPopView;
- (void)didInputPayPasswordError;



@end
