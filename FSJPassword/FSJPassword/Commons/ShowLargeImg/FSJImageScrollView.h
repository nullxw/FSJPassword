//
//  FSJImageScrollView.h
//  FSJPassword
//
//  Created by yto on 14-8-27.
//  Copyright (c) 2014年 yto_yewankun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSJImageScrollView : UIScrollView<UIScrollViewDelegate> {
    CGSize _imageSize;
}

@property (nonatomic, strong) UIImageView *zoomImageView;

- (void)displayImage:(UIImage *)image;

@end
