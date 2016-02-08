//
//  ViewController.h
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/7/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblPhotos;
@property (nonatomic) NSMutableArray *photosArray;
@property (weak, nonatomic) IBOutlet UISearchBar *flickrSearch;

@end

