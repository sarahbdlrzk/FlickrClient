//
//  FlickrFeed.h
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/8/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrFeed : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *url;
@property (nonatomic) NSString *owner;
@property (nonatomic) NSString *title;
@end
