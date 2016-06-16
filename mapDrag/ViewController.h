//
//  ViewController.h
//  mapDrag
//
//  Created by Sivakumar J on 29/10/13.
//  Copyright (c) 2013 gensler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController : UIViewController <GMSMapViewDelegate>{
    
    
    __weak IBOutlet UIButton *calloutView;
    __weak IBOutlet GMSMapView *mapView_;
    __weak IBOutlet UIImageView *curserPin;
}

- (IBAction)showlocation:(id)sender;
@end
