//
//  ViewController.m
//  mapDrag
//
//  Created by Sivakumar J on 29/10/13.
//  Copyright (c) 2013 gensler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    BOOL firstLocationUpdate_;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868 longitude:151.2086 zoom:12];
    
    [mapView_ setCamera:camera];
    
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    [mapView_ setDelegate:self];
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
  
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //[mapView_ setCenter:[mapView_.projection pointForCoordinate:mapView_.myLocation.coordinate]];
 
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    [calloutView setHidden:YES];
    NSLog(@"%s",__FUNCTION__);
    
}
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
    NSLog(@"%s",__FUNCTION__);
    
    
    [calloutView setHidden:NO];
    
    
}



- (void)dealloc {
    [mapView_ removeObserver:self forKeyPath:@"myLocation" context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showlocation:(id)sender {
    
    CGPoint point = mapView_.center;
    CLLocationCoordinate2D coor = [mapView_.projection coordinateForPoint:point];
    
    NSLog(@"coord %f %f",coor.latitude,coor.longitude);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Point" message:[NSString stringWithFormat:@"lat %f \n long %f",coor.latitude,coor.longitude] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
    
    
}
@end
