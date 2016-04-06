//
//  JSCountDownButton.m
//  JSCountDownButton
//
//  Created by V on 6/4/2016.
//  Copyright © 2016 V. All rights reserved.
//

#import "JSCountDownButton.h"


@interface JSCountDownButton ()

@property (nonatomic, copy)Touched touchHandler;
@property (nonatomic, copy)didChange didChangeHandler;
@property (nonatomic, copy)didFinish didFinishHandler;

@property (nonatomic, assign)NSInteger second;
@property (nonatomic, assign)NSInteger totalSecond;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSDate *startDate;

@end


@implementation JSCountDownButton

- (void)addTouchedHandler:(Touched)touchhandler{

    if (touchhandler) {
        _touchHandler = touchhandler;
    }
    
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)touched:(JSCountDownButton *)sender{

    if (_touchHandler) {
        _touchHandler(sender);
    }
    
}

- (void)startWithSecond:(NSInteger)second{

    _second = second;
    _totalSecond = second;
    _startDate = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart{
    
    double interval = [[NSDate date]timeIntervalSinceDate:_startDate];
    //计算剩余时间
    _second = _totalSecond - (int)interval + 0.5;
    
    if(_second < 0){
    
        [self stop];
    }
    else{
        
        if (_didChangeHandler) {
            
            [self setTitle:_didChangeHandler(self, _second) forState:UIControlStateNormal];
            [self setTitle:_didChangeHandler(self, _second) forState:UIControlStateDisabled];
        }
        else{
        
            [self setTitle:[NSString stringWithFormat:@"%ld", (long)_second] forState:UIControlStateDisabled];
            [self setTitle:[NSString stringWithFormat:@"%ld", (long)_second] forState:UIControlStateNormal];
        }
    
        
    }
}

- (void)stop{
    //[_timer invalidate];
    
    
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishHandler)
                {
                    [self setTitle: _didFinishHandler(self,_totalSecond)forState:UIControlStateNormal];
                    [self setTitle:_didFinishHandler(self,_totalSecond)forState:UIControlStateDisabled];
                    NSLog(@"123");
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}

- (void)didChanged:(didChange)handler{

    _didChangeHandler = handler;
}

- (void)didFinished:(didFinish)handler{

    _didFinishHandler = handler;
}


@end
