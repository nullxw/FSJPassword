//
//  GHCListPaging.m
//  GHCLishi
//
//  Created by 琥珀先知 on 14-1-23.
//  Copyright (c) 2014年 琥珀先知. All rights reserved.
//

#import "GHCListPaging.h"

@implementation GHCListPaging
@synthesize tableView;
@synthesize pageDelegate;
@synthesize notNeedRefresh;

#pragma mark - create 分页
- (void)createHeaderView {
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-tableView.bounds.size.height, tableView.frame.size.width, tableView.bounds.size.height)];
        view.delegate = self;
        [tableView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)setFooterView {
    // if the footerView is nil, then create it, reset the position of the foote
    CGFloat height = MAX(tableView.contentSize.height, tableView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              tableView.frame.size.width,
                                              tableView.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         tableView.frame.size.width, tableView.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [tableView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

- (void)didScroll {
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:tableView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:tableView];
    }
}

- (void)endScroll {
    if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:tableView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:tableView];
    }
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    [self beginToReloadData:aRefreshPos];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	return _reloading; // should return if data source model is reloading
}

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos {
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }
    else if(aRefreshPos == EGORefreshFooter){
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
}

- (void)refreshView {
    [self refreshData];
    [self testFinishedLoadData];
}

- (void)getNextPageView {
    [self nextPage];
    [self testFinishedLoadData];
}

-(void)testFinishedLoadData {
    [self finishReloadingData];
}

- (void)finishReloadingData{
	_reloading = NO;
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
    }
}

-(void)removeFooterView {
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

// 刷新
- (void)refreshData {
    NSLog(@"%s",__FUNCTION__);
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(updateData)]) {
        [self.pageDelegate updateData];
    }
}

// 下一页
- (void)nextPage {
    NSLog(@"%s",__FUNCTION__);
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(nextData)]) {
        [self.pageDelegate nextData];
    }
}

@end
