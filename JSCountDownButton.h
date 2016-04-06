//
//  JSCountDownButton.h
//  JSCountDownButton
//
//  Created by V on 6/4/2016.
//  Copyright © 2016 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSCountDownButton;

typedef void(^Touched)(JSCountDownButton *button);
typedef NSString *(^didChange)(JSCountDownButton *button, NSInteger second);
typedef NSString *(^didFinish)(JSCountDownButton *butotn, NSInteger second);


@interface JSCountDownButton : UIButton

- (void)didChanged:(didChange)handler;
- (void)didFinished:(didFinish)handler;

- (void)startWithSecond:(NSInteger)second;
- (void)addTouchedHandler:(Touched)touchhandler;
- (void)stop;

@end
