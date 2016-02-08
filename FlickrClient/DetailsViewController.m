//
//  DetailsViewController.m
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/8/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import "DetailsViewController.h"
#import "FlickrFeed.h"
@interface DetailsViewController ()
@end

@implementation DetailsViewController
@synthesize selectedFeed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:selectedFeed.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                        self.imgPhoto.image = image;
                        self.lblPhotoOwner.text=selectedFeed.owner;
                        self.lblPhotoTitle.text=selectedFeed.title;
                    
                });
            }
        }
    }];
    [task resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
