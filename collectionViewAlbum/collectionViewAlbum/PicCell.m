//
//  PicCell.m
//  collectionViewAlbum
//
//  Created by ray on 2018/6/14.
//  Copyright © 2018年 ray. All rights reserved.
//

#import "PicCell.h"

@interface PicCell()

@property(nonatomic, strong)UIImage *img;
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UIImageView *selectView;
@end

@implementation PicCell


-(void)config:(NSDictionary *)pic{
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-20)/3;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
     UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2,width/2, 10, 10)];
    [self addSubview:indicator];
    [indicator startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pic[@"galary_item_content"]]];
        _img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imgView.image = _img;
            [indicator stopAnimating];
            
        });//异步从网络加载图片
    });
    
    [self addSubview:_imgView];

}

-(void)configSelected:(NSDictionary *)pic{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-20)/3;
    _selectView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:pic[@"selected"]]];
    _selectView.frame = CGRectMake(width-width/4, 0, width/4, width/4);
    [self addSubview:_selectView];
}

@end
