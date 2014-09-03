//
//  GHCListPaging.h
//  GHCLishi
//
//  Created by 琥珀先知 on 14-1-23.
//  Copyright (c) 2014年 琥珀先知. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@protocol GHCListPagingDelegate <NSObject>

@optional
- (void)updateData;
- (void)nextData;

@end

@interface GHCListPaging : NSObject <EGORefreshTableDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _reloading;
}

@property (nonatomic,strong)UIScrollView *tableView;
@property (nonatomic,strong)id <GHCListPagingDelegate> pageDelegate;
@property (nonatomic,assign)BOOL notNeedRefresh; //yes:不需要刷新  no:需要刷新

- (void)createHeaderView;
- (void)setFooterView;
- (void)didScroll;
- (void)endScroll;
-(void)removeFooterView;
@end
