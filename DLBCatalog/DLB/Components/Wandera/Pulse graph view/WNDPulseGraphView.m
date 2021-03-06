//
//  WNDPulseGraphView.m
//  DLB
//
//  Created by Matic Oblak on 12/16/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import "WNDPulseGraphView.h"

@interface WNDPulseGraphView()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) CGFloat currentScale;
@end


@implementation WNDPulseGraphView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setDefaults];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self setDefaults];
    }
    return self;
}

- (void)setDefaults
{
    self.speed = .003f;
    self.lineDimmedColor = [[UIColor redColor] colorWithAlphaComponent:.1f];
    self.pulseHeadRadius = 10.0f;
    
    self.linePoints = @[
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(0/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(74.36/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(79.43/320.0),
                                                               (CGFloat)(((74.66/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(82.92/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(86.42/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(87.82/320.0),
                                                               (CGFloat)(((90.34/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(91.31/320.0),
                                                               (CGFloat)(((37.33/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(96.91/320.0),
                                                               (CGFloat)(((110/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(100.41/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(109.15/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(117.89/320.0),
                                                               (CGFloat)(((80.06/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(124.88/320.0),
                                                               (CGFloat)(((85.11/70.0) - 1.0)*-1.0))],
                        [NSNumber valueWithCGPoint:CGPointMake((CGFloat)(320/320.0),
                                                               (CGFloat)(((85.36/70.0) - 1.0)*-1.0))]
                        ];
    self.indicatorCount = 4;
}

- (void)setIndicatorCount:(NSInteger)indicatorCount
{
    self.currentScale = -1.0f;
    
    _indicatorCount = indicatorCount;
    CGFloat length = 1.8f/self.indicatorCount;
    
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    for(NSInteger i=0; i<indicatorCount; i++)
    {
        [ranges addObject:[DLBFloatingRange withLocation:.0f + (2.0f/indicatorCount)*i length:length]];
    }
    
    self.pulseRanges = ranges;
}

- (void)startAnimating
{
    [self stopAnimating];
    if(self.displayLink == nil)
    {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onFrame)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                               forMode:NSRunLoopCommonModes];
    }
}
- (void)stopAnimating
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}
- (void)onFrame
{
    self.currentScale += self.speed;
    while(self.currentScale > 1.0f)
    {
        self.currentScale -= 1.0f;
    }
    [self commitIndicators];
}

- (void)commitIndicators
{
    CGFloat stepSize = 2.0f/self.indicatorCount;
    
    for(NSInteger i=0; i<self.indicatorCount; i++)
    {
        DLBFloatingRange *range = self.pulseRanges[i];
        range.location = self.currentScale - 1.0f + stepSize*(i+1);
    }
    
    [self setNeedsDisplay];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self stopAnimating];
}

@end
