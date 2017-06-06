//
//  NavButton.m
//  Marvoto
//
//  Created by 谭伟华 on 16/5/18.
//  Copyright © 2016年 LBS. All rights reserved.
//

#import "NavButton.h"

@implementation NavButton

- (instancetype)initWithBtnStr:(NSString *)btnStr
          horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                btnActionBlock:(void(^)())btnActionBlock
{
    if (self = [super init])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btn setTitle:btnStr forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setContentHorizontalAlignment:horizontalAlignment];
        self.customView = btn;
        _btnBlock = btnActionBlock;
    }

    return self;
}

- (instancetype)initWithBtnImg:(NSString *)btnImg
           horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment
                btnActionBlock:(void(^)())btnActionBlock
{
    if (self = [super init])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        btn.contentMode = UIViewContentModeScaleAspectFit;
        btn.backgroundColor = [UIColor clearColor];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setContentHorizontalAlignment:horizontalAlignment];
        self.customView = btn;
        _btnBlock = btnActionBlock;
    }
    
    return self;
}


- (void)btnAction
{
    if (self.btnBlock) {
        
        self.btnBlock();
    }
}

- (instancetype)initWithBtnImg:(NSString *)btnImg delegate:(id<NavLeftBtnDelegate>)delegate
{
    if (self = [super init])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        btn.contentMode = UIViewContentModeScaleAspectFit;
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDelegateAction) forControlEvents:UIControlEventTouchUpInside];
        self.customView = btn;
        // 设置代理，外部实现代理方法
        self.delegate = delegate;
    }
    
    return self;
}

- (void)btnDelegateAction
{
    if ([_delegate respondsToSelector:@selector(back)])
    {
        [_delegate back];
    }   
}

@end
