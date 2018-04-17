/**
 * Copyright (c) 2016-present, K.
 * All rights reserved.
 *
 * Email:xorshine@icloud.com
 *
 * This source code is licensed under the MIT license.
 */

#define KafkaColorWithRGBA(r,g,b,a)  \
[UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:(a)]

#import "KafkaReplicatorLayer.h" 
#import "CALayer+KafkaLayout.h"
#import "KafkaRefreshDefaults.h"
#import <objc/runtime.h>

static void * KafkaLeftDot = &KafkaLeftDot;
static void * KafkaRightDot = &KafkaRightDot;

@implementation KafkaReplicatorLayer

- (instancetype)init{
	self = [super init];
	if (self) {
		[self setupProperties];
	}
	return self;
}

- (void)setupProperties{
	[self addSublayer:self.replicatorLayer];
	[self.replicatorLayer addSublayer:self.indicatorShapeLayer];
	
	self.indicatorShapeLayer.strokeColor = [KafkaRefreshDefaults standardRefreshDefaults].fillColor.CGColor;
	self.indicatorShapeLayer.backgroundColor = [KafkaRefreshDefaults standardRefreshDefaults].backgroundColor.CGColor;
}

- (void)setAnimationStyle:(KafkaReplicatorLayerAnimationStyle)animationStyle{
	if (_animationStyle != animationStyle) {
		_animationStyle = animationStyle;
		[self setNeedsLayout];
	}
}

- (void)layoutSublayers{
	[super layoutSublayers];
	self.replicatorLayer.frame = CGRectMake(0, 0, self.kaf_height, self.kaf_height);
	self.replicatorLayer.position = CGPointMake(self.kaf_width/2., self.kaf_height/2.);
	
	CGFloat padding = 5.;
	switch (self.animationStyle) {
		case KafkaReplicatorLayerAnimationStyleWoody:{
			self.indicatorShapeLayer.frame = CGRectMake(padding, self.kaf_height/4, 3., self.kaf_height/3.);
			self.indicatorShapeLayer.cornerRadius = 1.;
			self.indicatorShapeLayer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8);
			
			self.replicatorLayer.instanceCount = 5;
			self.replicatorLayer.instanceDelay = 0.3/5;
			self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(10., 0.0, 0.0);
			self.replicatorLayer.instanceBlueOffset = -0.01;
			self.replicatorLayer.instanceGreenOffset = -0.01;
			break;
		}
		case KafkaReplicatorLayerAnimationStyleAllen:{
			self.indicatorShapeLayer.frame = CGRectMake(padding, self.kaf_height/4+15,3., self.kaf_height/3.);
			self.indicatorShapeLayer.cornerRadius = 1.;
			
			self.replicatorLayer.instanceCount = 5;
			self.replicatorLayer.instanceDelay = 0.3/5;
			self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(10., 0.0, 0.0);
			self.replicatorLayer.instanceBlueOffset = -0.01;
			self.replicatorLayer.instanceGreenOffset = -0.01;
			break;
		}
		case KafkaReplicatorLayerAnimationStyleCircle:{
			self.indicatorShapeLayer.frame = CGRectMake(self.replicatorLayer.kaf_width/2., 10, 4., 4.);
			self.indicatorShapeLayer.cornerRadius = 2.;
			self.indicatorShapeLayer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2);
			
			self.replicatorLayer.instanceCount = 12;
			self.replicatorLayer.instanceDelay = 0.8/12;
			CGFloat angle = (2 * M_PI)/self.replicatorLayer.instanceCount;
			self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 0.1);
			self.replicatorLayer.instanceBlueOffset = -0.01;
			self.replicatorLayer.instanceGreenOffset = -0.01;
			break;
		}
		case KafkaReplicatorLayerAnimationStyleDot:{
			self.indicatorShapeLayer.frame = CGRectMake(0, self.kaf_height/2.,4, 4);
			self.indicatorShapeLayer.cornerRadius = 2.;
			
			self.replicatorLayer.instanceCount = 3;
			self.replicatorLayer.instanceDelay = 0.5/3;
			self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(30., 0.0, 0.0);
			break;
		}
		case KafkaReplicatorLayerAnimationStyleArc:{
			self.indicatorShapeLayer.frame = CGRectMake(0, 0, self.replicatorLayer.kaf_height, self.replicatorLayer.kaf_height);
			self.indicatorShapeLayer.fillColor = [UIColor clearColor].CGColor;
			self.indicatorShapeLayer.lineWidth = 3.;
			self.indicatorShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
			UIBezierPath *arcPath = [UIBezierPath bezierPath];
			[arcPath addArcWithCenter:self.indicatorShapeLayer.position
							   radius:18.
						   startAngle:M_PI/6
							 endAngle:-M_PI/6
							clockwise:NO];
			self.indicatorShapeLayer.path = arcPath.CGPath;
			
			self.replicatorLayer.instanceCount = 2;
			self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 0, 0, 0.1);
			break;
		}
		case KafkaReplicatorLayerAnimationStyleTriangle:{
			self.indicatorShapeLayer.frame = CGRectMake(self.replicatorLayer.kaf_width/2., 5., 8., 8.);
			self.indicatorShapeLayer.cornerRadius = self.indicatorShapeLayer.kaf_width/2.;
			CGPoint topPoint = self.indicatorShapeLayer.position;
			CGPoint leftPoint = CGPointMake(topPoint.x-15, topPoint.y+23);
			CGPoint rightPoint = CGPointMake(topPoint.x+15, topPoint.y+23);
			
			CAShapeLayer *leftCircle = [self leftCircle];
			CAShapeLayer *rightCircle = [self rithtCircle];
			if (leftCircle)
				[leftCircle removeFromSuperlayer];
			if (rightCircle)
				[rightCircle removeFromSuperlayer];
			
			leftCircle.kaf_size = self.indicatorShapeLayer.kaf_size;
			leftCircle.position = leftPoint;
			leftCircle.cornerRadius = self.indicatorShapeLayer.cornerRadius;
			[self.replicatorLayer addSublayer:leftCircle];
			 
			rightCircle.kaf_size = self.indicatorShapeLayer.kaf_size;
			rightCircle.position = rightPoint;
			rightCircle.cornerRadius = self.indicatorShapeLayer.cornerRadius;
			[self.replicatorLayer addSublayer:rightCircle];
			break;
		}
	}
}

- (void)startAnimating{
	[self.indicatorShapeLayer removeAllAnimations];
	switch (self.animationStyle) {
		case KafkaReplicatorLayerAnimationStyleWoody:{
			CABasicAnimation *basicAnimation = [self animationKeyPath:@"transform.scale.y"
																 from:@(1.5)
																   to:@(0.0)
															 duration:0.3
														   repeatTime:INFINITY];
			basicAnimation.autoreverses = YES;
			[self.indicatorShapeLayer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
			break;
		}
		case KafkaReplicatorLayerAnimationStyleAllen:{
			CABasicAnimation *basicAnimation = [self animationKeyPath:@"position.y"
																 from:@(self.indicatorShapeLayer.position.y)
																   to:@(self.indicatorShapeLayer.position.y-15)
															 duration:0.3
														   repeatTime:INFINITY];
			basicAnimation.autoreverses = YES;
			[self.indicatorShapeLayer addAnimation:basicAnimation forKey:basicAnimation.keyPath]; 
			break;
		}
		case KafkaReplicatorLayerAnimationStyleCircle:{
			CABasicAnimation *basicAnimation = [self animationKeyPath:@"transform.scale"
																 from:@(1.0)
																   to:@(0.2)
															 duration:0.8
														   repeatTime:INFINITY];
			[self.indicatorShapeLayer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
			break;
		}
		case KafkaReplicatorLayerAnimationStyleDot:{
			CABasicAnimation *basicAnimation = [self animationKeyPath:@"transform.scale"
																 from:@(0.3)
																   to:@(4.)
															 duration:0.5
														   repeatTime:INFINITY];
			basicAnimation.autoreverses = YES;
			CABasicAnimation * opc = [self animationKeyPath:@"opacity"
													   from:@(0.1)
														 to:@(1.0)
												   duration:0.5
												 repeatTime:INFINITY];
			
			opc.autoreverses = YES;
			CAAnimationGroup * group = [CAAnimationGroup animation];
			group.animations = @[basicAnimation,opc];
			group.autoreverses = YES;
			group.repeatCount = INFINITY;
			group.duration = 0.5;
			[self.indicatorShapeLayer addAnimation:group forKey:basicAnimation.keyPath];
			break;
		}
		case KafkaReplicatorLayerAnimationStyleArc:{
			CABasicAnimation *basicAnimation = [self animationKeyPath:@"transform.rotation.z"
																 from:@(0.0)
																   to:@(2*M_PI)
															 duration:0.8
														   repeatTime:INFINITY];
			[self.indicatorShapeLayer addAnimation:basicAnimation forKey:basicAnimation.keyPath];
			break;
		}
		case KafkaReplicatorLayerAnimationStyleTriangle:{
			CAShapeLayer *leftCircle = objc_getAssociatedObject(self, KafkaLeftDot);
			CAShapeLayer *rightCircle = objc_getAssociatedObject(self, KafkaRightDot);
			
			CGPoint topPoint = self.indicatorShapeLayer.position;
			CGPoint leftPoint = leftCircle.position;
			CGPoint rightPoint = rightCircle.position;
			
			NSArray *vertexs = @[[NSValue valueWithCGPoint:topPoint],
								 [NSValue valueWithCGPoint:leftPoint],
								 [NSValue valueWithCGPoint:rightPoint]];
			
			CAKeyframeAnimation *key0 = [self keyFrameAnimationWithPath:[self trianglePathWithStartPoint:topPoint vertexs:vertexs] duration:1.5];
			[self.indicatorShapeLayer addAnimation:key0 forKey:key0.keyPath];
			
			CAKeyframeAnimation *key1 = [self keyFrameAnimationWithPath:[self trianglePathWithStartPoint:leftPoint vertexs:vertexs] duration:1.5];
			[rightCircle addAnimation:key1 forKey:key1.keyPath];
			
			CAKeyframeAnimation *key2 = [self keyFrameAnimationWithPath:[self trianglePathWithStartPoint:rightPoint vertexs:vertexs] duration:1.5];
			[leftCircle addAnimation:key2 forKey:key2.keyPath];
			break;
		}
	}
}

- (void)stopAnimating{
	[self.indicatorShapeLayer removeAllAnimations];
	if (self.animationStyle == KafkaReplicatorLayerAnimationStyleTriangle) {
		CAShapeLayer *leftCircle = objc_getAssociatedObject(self, KafkaLeftDot);
		[leftCircle removeAllAnimations];
		CAShapeLayer *rightCircle = objc_getAssociatedObject(self, KafkaRightDot);
		[rightCircle removeAllAnimations];
	}
}

- (CABasicAnimation *)animationKeyPath:(NSString *)keyPath
									   from:(NSNumber *)fromValue
									  to:(NSNumber *)toValue
								duration:(CFTimeInterval)duration
							  repeatTime:(CGFloat)repeat {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
	animation.fromValue = fromValue;
	animation.toValue = toValue;
	animation.duration = duration;
	animation.repeatCount = repeat;
	animation.removedOnCompletion = NO;
	return animation;
}

- (CAKeyframeAnimation *)keyFrameAnimationWithPath:(UIBezierPath *)path
										  duration:(NSTimeInterval)duration {
	CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
	animation.keyPath = @"position";
	animation.path = path.CGPath;
	animation.duration = duration;
	animation.repeatCount = INFINITY;
	animation.removedOnCompletion = NO;
	return animation;
}

- (UIBezierPath *)trianglePathWithStartPoint:(CGPoint)startPoint vertexs:(NSArray *)vertexs {
	CGPoint topPoint  = [[vertexs objectAtIndex:0] CGPointValue];
	CGPoint leftPoint  = [[vertexs objectAtIndex:1] CGPointValue];
	CGPoint rightPoint  = [[vertexs objectAtIndex:2] CGPointValue];
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	
	if (CGPointEqualToPoint(startPoint, topPoint) ) {
		[path moveToPoint:startPoint];
		[path addLineToPoint:rightPoint];
		[path addLineToPoint:leftPoint];
	} else if (CGPointEqualToPoint(startPoint, leftPoint)) {
		[path moveToPoint:startPoint];
		[path addLineToPoint:topPoint];
		[path addLineToPoint:rightPoint];
	} else {
		[path moveToPoint:startPoint];
		[path addLineToPoint:leftPoint];
		[path addLineToPoint:topPoint];
	}
	
	[path closePath];
	
	return path;
}

- (CAShapeLayer *)leftCircle{
	CAShapeLayer *leftCircle = objc_getAssociatedObject(self, KafkaLeftDot);
	if (!leftCircle) {
		leftCircle = [CAShapeLayer layer];
		leftCircle.backgroundColor = self.indicatorShapeLayer.backgroundColor;
		objc_setAssociatedObject(self, KafkaLeftDot, leftCircle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return leftCircle;
}

- (CAShapeLayer *)rithtCircle{
	CAShapeLayer *rightCircle = objc_getAssociatedObject(self, KafkaRightDot);
	if (!rightCircle) {
		rightCircle = [CAShapeLayer layer];
		rightCircle.backgroundColor = self.indicatorShapeLayer.backgroundColor;
		objc_setAssociatedObject(self, KafkaRightDot, rightCircle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return rightCircle;
}

- (CAShapeLayer *)indicatorShapeLayer{
	if (!_indicatorShapeLayer) {
		_indicatorShapeLayer = [CAShapeLayer layer];
		_indicatorShapeLayer.contentsScale = [[UIScreen mainScreen] scale];
	}
	return _indicatorShapeLayer;
}

- (CAReplicatorLayer *)replicatorLayer{
	if (!_replicatorLayer) {
		_replicatorLayer = [CAReplicatorLayer layer];
		_replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
		_replicatorLayer.shouldRasterize = YES;
		_replicatorLayer.rasterizationScale = [[UIScreen mainScreen] scale];
	}
	return _replicatorLayer;
}

@end
