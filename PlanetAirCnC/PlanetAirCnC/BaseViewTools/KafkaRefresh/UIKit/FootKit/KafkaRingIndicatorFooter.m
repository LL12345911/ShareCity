/**
 * Copyright (c) 2016-present, K.
 * All rights reserved.
 *
 * e-mail:xorshine@icloud.com
 * github:https://github.com/xorshine
 *
 * This source code is licensed under the MIT license.
 */

#import "KafkaRingIndicatorFooter.h" 

@implementation KafkaRingIndicatorFooter

- (void)setupProperties{
	[super setupProperties];
	[self.layer addSublayer:self.arcLayer];
	[self addSubview:self.indicator];
}

- (void)layoutSubviews{
	[super layoutSubviews];
	self.arcLayer.frame = CGRectMake(0, 0, self.kaf_width, self.kaf_height);
	self.indicator.center = CGPointMake(self.kaf_width/2., self.kaf_height/2.);
}

- (void)setFillColor:(UIColor *)fillColor{
	if (super.fillColor == fillColor) {
		return;
	}
	[super setFillColor:fillColor];
	self.arcLayer.ringFillColor = fillColor; 
}

- (void)setAnimatedBackgroundColor:(UIColor *)animatedBackgroundColor{
	if (super.animatedBackgroundColor == animatedBackgroundColor) {
		return;
	}
	[super setAnimatedBackgroundColor:animatedBackgroundColor];
	self.arcLayer.ringBackgroundColor = animatedBackgroundColor;
}

- (void)kafkaDidScrollWithProgress:(CGFloat)progress max:(const CGFloat)max{
	[self.arcLayer setProgress:progress];
}

- (void)kafkaRefreshStateDidChange:(KafkaRefreshState)state{
	[super kafkaRefreshStateDidChange:state];
	switch (state) {
		case KafkaRefreshStateNone:{
			break;
		}
		case KafkaRefreshStateScrolling:{
			break;
		}
		case KafkaRefreshStateReady:{
			self.arcLayer.opacity = 1.;
			break;
		}
		case KafkaRefreshStateRefreshing:{
			[self.arcLayer startAnimating];
			self.arcLayer.hidden = YES;
			[self.indicator startAnimating];
			break;
		}
		case KafkaRefreshStateWillEndRefresh:{
			[self.indicator stopAnimating];
			self.arcLayer.hidden = NO;
			[self.arcLayer stopAnimating];
			break;
		}
	}
}

- (KafkaArcLayer *)arcLayer{
	if (!_arcLayer) {
		_arcLayer = [KafkaArcLayer layer];
	}
	return _arcLayer;
}

- (UIActivityIndicatorView *)indicator{
	if (!_indicator) {
		_indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_indicator.hidesWhenStopped = YES;
	}
	return _indicator;
}

@end
