//
//  HUDTools.m
//  AtsmartHome
//
//  Created by shengxiao on 15/8/20.
//  Copyright (c) 2015年 Atsmart. All rights reserved.
//

#import "HUDTools.h"

static MBProgressHUD    *HUD;
static HUDHandlerBlock  _handlerBlock;

@implementation HUDTools

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view {
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    
    HUD.label.text = labelText;
    HUD.label.font = [UIFont systemFontOfSize:16.0f];
    [HUD showAnimated:YES];
    
    return HUD;
}

+(MBProgressHUD *) showHUDWithDetailLabel:(NSString *) detailLabelText withView:(UIView *) view {
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    
    HUD.detailsLabel.text = detailLabelText;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:16.0f];
    [HUD showAnimated:YES];
    
    return HUD;
}

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText {
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    //HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    HUD.label.text = labelText;
    [HUD showAnimated:YES];
    
    return HUD;
}

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view withColor:(UIColor *) color {
    HUD = [self showHUDWithLabel:labelText withView:view];
    HUD.bezelView.color = color;

    return HUD;
}

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText withColor:(UIColor *) color {
    HUD = [self showHUDOnWindowWithLabel:labelText];
    HUD.bezelView.color = color;//.bezelView.color
    
    return HUD;
}

+(MBProgressHUD *) showTransparentHUDWithLabel:(NSString *) labelText withView:(UIView *) view {
    HUD = [self showHUDWithLabel:labelText withView:view];
    HUD.bezelView.color = [UIColor clearColor];
    
    return HUD;

}

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText withLabelTextColor:(UIColor *) textColor {
    HUD = [self showHUDOnWindowWithLabel:labelText];
    HUD.bezelView.color = [UIColor clearColor];
    HUD.label.textColor = textColor;
    
    return HUD;
}

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText {
    HUD = [self showHUDOnWindowWithLabel:labelText];
    HUD.bezelView.color = [UIColor clearColor];
    
    return HUD;
}

+(MBProgressHUD *) changeLabelText:(NSString *) labelText {
    if (HUD == nil) {
        return nil;
    }
    HUD.label.text = labelText;
    
    return HUD;
}

+(MBProgressHUD *) changeDetailLabelText:(NSString *) labelText {
    if (HUD == nil) {
        return nil;
    }
    HUD.detailsLabel.text = labelText;
    
    return HUD;
}

+ (void) removeHUD {
    [HUD removeFromSuperview];
    [HUD hideAnimated:YES afterDelay:0];
    [HUD removeFromSuperViewOnHide];
}

+ (void) removeHUDAfterDelay:(float) time {
     [HUD hideAnimated:YES afterDelay:time];
    [HUD removeFromSuperViewOnHide];
}

+ (void) removeHUDAfterDelay:(float) time withAfterDelayHandler:(HUDHandlerBlock) handler {
    [self removeHUDAfterDelay:time];
    _handlerBlock = handler;
    [self performSelector:@selector(handleAction)
               withObject:nil
               afterDelay:time];
}

+ (void)showText:(NSString *) text withView:(UIView *) view withDelay:(float) time {
    
     dispatch_async(dispatch_get_main_queue(), ^{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    hud.label.text = text;
    hud.label.textColor = [UIColor whiteColor];
         hud.label.numberOfLines = 0;
//    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.font = [UIFont systemFontOfSize:16.0f];
    [hud hideAnimated:YES afterDelay:time];
     });
}


/**
 @description 显示详情信息(多行)

 @param text 文本信息
 @param view 在哪个视图上显示
 @param time 消失时间
 */
+ (void)showDetailText:(NSString *) text withView:(UIView *) view withDelay:(float) time {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.0f];

     hud.bezelView.color = [UIColor blackColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    
   [hud hideAnimated:YES afterDelay:time];
}

+(void) handleAction {
    if (_handlerBlock != nil) {
        _handlerBlock();
        _handlerBlock = nil;
    }
}
@end
