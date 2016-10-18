//
//  MapViewController.m
//  Track
//
//  Created by zhe wu on 4/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)openBrowser:(id)sender;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.trackingLabel.text = self.tracking;
    NSLog(@"self.tracking=%@", self.tracking);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"PackageList.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"PackageList" ofType:@"plist"];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
   // NSLog(@"dict = %@",dict);
    
    self.status.text = [[dict objectForKey: self.trackingLabel.text] objectForKey:@"status_details"];
    self.statusData.text = [[dict objectForKey: self.trackingLabel.text] objectForKey:@"status_date"];
    
    self.mapView.delegate = self;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    NSString *zip = [[[dict objectForKey: self.trackingLabel.text] objectForKey:@"location"] objectForKey:@"zip"];
    //NSLog(@"zip = %@", zip);
    CLLocationCoordinate2D center = [self getLocationFromAddressString:zip];
    annotation.coordinate = center;
    annotation.title = @"package location";
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(center, 20000, 20000) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



- (IBAction)openBrowser:(id)sender {
    
    NSString *checkCarrier = [_tracking substringWithRange:NSMakeRange(0,1)];
    
    if ([checkCarrier isEqualToString:@"9"]) {
        NSString *host = @"https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=";
        NSString *trackingNumber = self.tracking;
        NSString *url = [host stringByAppendingString:trackingNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if ([checkCarrier isEqualToString:@"6"]){
        NSString *host = @"http://fedex.com/Tracking?action=track&language=english&cntry_code=us&tracknumbers=";
        NSString *trackingNumber = self.tracking;
        NSString *url = [host stringByAppendingString:trackingNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        NSString *host = @"http://wwwapps.ups.com/WebTracking/track?loc=en_US&track.x=Track&trackNums=";
        NSString *trackingNumber = self.tracking;
        NSString *url = [host stringByAppendingString:trackingNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
       
    }
}

-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    //    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", addressStr];
    //NSLog(@"%@", req);
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    //  NSLog(@"%f, %f", center.latitude, center.longitude);
    return center;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"map"];
    annotationView.canShowCallout = YES;
    return annotationView;
}

@end
