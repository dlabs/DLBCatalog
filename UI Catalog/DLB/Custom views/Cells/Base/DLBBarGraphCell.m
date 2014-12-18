//
//  DLBBarGraphCell.m
//  DLB
//
//  Created by Matic Oblak on 12/18/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import "DLBBarGraphCell.h"
#import "DLBBarGraphView.h"

@interface DLBBarGraphCell()<DLBBarGraphDataSource>
@property (weak, nonatomic) IBOutlet DLBBarGraphView *barGraph;
@property (nonatomic) BOOL animate;
@end


@implementation DLBBarGraphCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.barGraph.dataSource = self;
    self.barGraph.nodeBackgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.2f];
    self.barGraph.nodeColor = [UIColor blueColor];
    self.barGraph.barWidth = 8.0f;
    
    self.animate = YES;
    [self performSelector:@selector(scramble) withObject:nil afterDelay:1.0];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    self.animate = NO;
}

- (NSInteger)DLBBarGraphViewNumberOfComponents:(DLBBarGraphView *)sender
{
    NSInteger toRetunr = 5 + rand()%30;
    return toRetunr;
}

- (NSNumber *)DLBBarGraphView:(DLBBarGraphView *)sender valueAtIndex:(NSInteger)index
{
    CGFloat value = (CGFloat)(rand()%100)/100.0f;
    return @(value);
}

- (void)scramble
{
    CGFloat redScale = (CGFloat)(rand()%100)/100.0f;
    self.barGraph.nodeColor = [UIColor colorWithRed:redScale green:.0f blue:1.0f-redScale alpha:1.0f];
    [self.barGraph reloadGraphAnimated:YES];
    if(self.animate)
    {
        [self performSelector:@selector(scramble) withObject:nil afterDelay:3.0];
    }
}


@end
