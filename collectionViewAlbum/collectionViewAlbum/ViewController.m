//
//  ViewController.m
//  collectionViewAlbum
//
//  Created by ray on 2018/6/14.
//  Copyright © 2018年 ray. All rights reserved.
//



#import "ViewController.h"
#import "PicCell.h"




@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *cv;
@property(nonatomic, strong)UILabel *selectedLabel;
@property(nonatomic, strong)UIButton *deleteBtn;
@property(nonatomic, strong)UIButton *selectedAllBtn;

@property(nonatomic, strong)NSMutableArray *dataSource;

@property(nonatomic, assign)BOOL allSelected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jsonToDataSource];
    [self creatCV];
    
}

-(void)creatCV{
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-20)/3;
    CGFloat sWidth = ([UIScreen mainScreen].bounds.size.width);
    CGFloat sHeight = ([UIScreen mainScreen].bounds.size.height);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(width, width);
    
    _cv = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _cv.backgroundColor = [UIColor whiteColor];
    _cv.delegate = self;
    _cv.dataSource = self;

    [_cv registerClass:[PicCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_cv];
    
    
//    下边的操作按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, sHeight-45, sWidth, 45)];
    footerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    [self.view addSubview:footerView];
    _selectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sWidth/3, 45)];
    _selectedLabel.textAlignment = NSTextAlignmentCenter;
    _selectedLabel.textColor = [UIColor orangeColor];
    _selectedLabel.text = @"已选中0张";
    [footerView addSubview:_selectedLabel];
    
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(sWidth/3, 0, sWidth/3, 45)];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteHandler) forControlEvents:UIControlEventTouchUpInside];
     [footerView addSubview:_deleteBtn];
    
    _selectedAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(sWidth/3*2, 0, sWidth/3, 45)];
    [_selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_selectedAllBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_selectedAllBtn addTarget:self action:@selector(selectAllHandler) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_selectedAllBtn];
}

-(void)deleteHandler{
    for (int i = 0 ; i < _dataSource.count; i++) {
        if([_dataSource[i][@"selected"]  isEqual: @"sel"]){
            [_dataSource removeObjectAtIndex:i];
        }
    }
    [_cv reloadData];
}

-(void)selectAllHandler{
    
    for (int i = 0 ; i < _dataSource.count; i++) {
        _dataSource[i][@"selected"] = _allSelected?@"def":@"sel";
    }
    _allSelected = !_allSelected;
    [_cv reloadData];
}


/**
 获取数据
 */
-(void)jsonToDataSource{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _dataSource = json[@"data"];
    for (int i = 0 ; i < _dataSource.count; i++) {
        _dataSource[i][@"selected"] = @"def";
    }
    _allSelected = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of an;y resources that can be recreated.
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PicCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [cell config: _dataSource[indexPath.row]];
    [cell configSelected:_dataSource[indexPath.row]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_dataSource[indexPath.row]);
    
    _dataSource[indexPath.row][@"selected"] = [_dataSource[indexPath.row][@"selected"]  isEqual: @"sel"]? @"def":@"sel";
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    int count = 0;
    for (NSDictionary *dic in _dataSource) {
        if([dic[@"selected"]  isEqual: @"sel"]){
            count = count + 1;
        }
        
    }
    _selectedLabel.text =  [NSString stringWithFormat:@"已选中%d张",count];
}


@end
