/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNCSlider.h"

@implementation RNCSlider {
  float _unclippedValue;
  UITapGestureRecognizer * tapGesturer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    tapGesturer = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapHandler:)];
    [tapGesturer setNumberOfTapsRequired: 1];
    [self addGestureRecognizer:tapGesturer];
  }
  return self;
}
- (void)tapHandler:(UITapGestureRecognizer *)gesture {
  CGPoint touchPoint = [gesture locationInView:self];
  [self setValue:touchPoint.x / self.bounds.size.width animated: YES];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  return YES;
}

- (void)setValue:(float)value {
  _unclippedValue = value;
  super.value = value;
}

- (void)setValue:(float)value animated:(BOOL)animated {
  _unclippedValue = value;
  [super setValue:value animated:animated];
}

- (void)setMinimumValue:(float)minimumValue {
  super.minimumValue = minimumValue;
  super.value = _unclippedValue;
}

- (void)setMaximumValue:(float)maximumValue {
  super.maximumValue = maximumValue;
  super.value = _unclippedValue;
}

- (void)setTrackImage:(UIImage *)trackImage {
  if (trackImage != _trackImage) {
    _trackImage = trackImage;
    CGFloat width = trackImage.size.width / 2;
    UIImage *minimumTrackImage = [trackImage resizableImageWithCapInsets:(UIEdgeInsets){
      0, width, 0, width
    } resizingMode:UIImageResizingModeStretch];
    UIImage *maximumTrackImage = [trackImage resizableImageWithCapInsets:(UIEdgeInsets){
      0, width, 0, width
    } resizingMode:UIImageResizingModeStretch];
    [self setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:maximumTrackImage forState:UIControlStateNormal];
  }
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
  _trackImage = nil;
  minimumTrackImage = [minimumTrackImage resizableImageWithCapInsets:(UIEdgeInsets){
    0, minimumTrackImage.size.width, 0, 0
  } resizingMode:UIImageResizingModeStretch];
  [self setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
}

- (UIImage *)minimumTrackImage {
  return [self thumbImageForState:UIControlStateNormal];
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
  _trackImage = nil;
  maximumTrackImage = [maximumTrackImage resizableImageWithCapInsets:(UIEdgeInsets){
    0, 0, 0, maximumTrackImage.size.width
  } resizingMode:UIImageResizingModeStretch];
  [self setMaximumTrackImage:maximumTrackImage forState:UIControlStateNormal];
}

- (UIImage *)maximumTrackImage {
  return [self thumbImageForState:UIControlStateNormal];
}

- (void)setThumbImage:(UIImage *)thumbImage {
  [self setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (UIImage *)thumbImage {
  return [self thumbImageForState:UIControlStateNormal];
}

- (void)setInverted:(BOOL)inverted {
  if (inverted) {
    self.transform = CGAffineTransformMakeScale(-1, 1);
  } else {
    self.transform = CGAffineTransformMakeScale(1, 1);
  }
}

@end
