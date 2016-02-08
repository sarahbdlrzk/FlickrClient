//
//  FlickrFeedTableViewCell.h
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/8/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
