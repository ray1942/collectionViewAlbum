//
//  PicCell.h
//  collectionViewAlbum
//
//  Created by ray on 2018/6/14.
//  Copyright © 2018年 ray. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PicCell : UICollectionViewCell

-(void)config:(NSDictionary *)pic;
-(void)configSelected:(NSDictionary *)pic;

@end
