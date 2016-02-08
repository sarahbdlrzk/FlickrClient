//
//  DetailsViewController.h
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/8/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlickrFeed;
@interface DetailsViewController : UIViewController
@property(nonatomic,retain)FlickrFeed *selectedFeed;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@property (weak, nonatomic) IBOutlet UILabel *lblPhotoOwner;
@property (weak, nonatomic) IBOutlet UILabel *lblPhotoTitle;
@end
