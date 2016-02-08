//
//  ViewController.m
//  FlickrClient
//
//  Created by Sarah Abdelrazak on 2/7/16.
//  Copyright © 2016 Sarah Abdelrazak. All rights reserved.
//

#import "ViewController.h"
#import <FlickrKit.h>
#import "FlickrFeedTableViewCell.h"
#import "FlickrFeed.h"
#import "SVProgressHUD.h"
#import "DetailsViewController.h"
#define kFlickrPhotosFlickrAPIKey                 @"3e35f49480d5b6f03a135e8e3150e017"
#define kFlickrPhotosFlickrAPISecret              @"5bb5938ff09d7930"
@interface ViewController (){
    FlickrFeed *selectedFeed;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _photosArray=[NSMutableArray array];
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:kFlickrPhotosFlickrAPIKey sharedSecret:kFlickrPhotosFlickrAPISecret];

}



-(void) loadPhotosForKeyWord:(NSString*) keywords{
    
    if(_photosArray){
        [_photosArray removeAllObjects];
    }
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrPhotosSearch *photoSearch = [[FKFlickrPhotosSearch alloc] init];
    photoSearch.text=keywords;
    [SVProgressHUD showWithStatus:@"loading..."];
    [fk call:photoSearch completion:^(NSDictionary *response, NSError *error) {
        // Note this is not the main thread!
        if (response) {
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                FlickrFeed *feed= [[FlickrFeed alloc] init];
                feed.url=[fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                feed.title=[photoData objectForKey:@"title"];
                feed.owner=[photoData objectForKey:@"owner"];
                if (feed) {
                    [_photosArray addObject:feed];
                }
           
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // Any GUI related operations here
                [self.tblPhotos reloadData];
                [SVProgressHUD dismiss];

            });
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _photosArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *CellIdentifier = @"FlickrFeedCell";
    FlickrFeedTableViewCell *cell = (FlickrFeedTableViewCell *)[self.tblPhotos dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[FlickrFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    FlickrFeed *feed = [_photosArray objectAtIndex:indexPath.row];
    cell.imgPhoto.image = nil;
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:feed.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FlickrFeedTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        cell.imgPhoto.image = image;
                });
            }
        }
    }];
    [task resume];
    
    return cell;
    
}
// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    @try {
        if(selectedFeed){
            DetailsViewController*detailsController = (DetailsViewController*)segue.destinationViewController;
            detailsController.selectedFeed = selectedFeed;
            
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedFeed=nil;
    selectedFeed = [_photosArray objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"details" sender:tableView];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (searchBar.text.length>0) {
        [self.photosArray removeAllObjects];
        [self.tblPhotos reloadData];
        [self loadPhotosForKeyWord:searchBar.text];
        [searchBar resignFirstResponder];
    }
  
    
}

@end
