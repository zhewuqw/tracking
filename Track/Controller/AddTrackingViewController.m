//
//  AddTrackingViewController.m
//  Track
//
//  Created by zhe wu on 4/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "AddTrackingViewController.h"
#import "MapViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import "CoreDataStack.h"
#import <CoreData/CoreData.h>
#import <RestKit.h>
#import "TrackInfo.h"



@interface AddTrackingViewController () <UIPickerViewDataSource, UIPickerViewDelegate, AVCaptureMetadataOutputObjectsDelegate>
{
    NSArray *carrierArray;
    AVCaptureSession * session;
}

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UILabel *carriersLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackingLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancal;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *scanlayer;
@property (weak, nonatomic) IBOutlet UITextField *trackingInput;
@property (weak, nonatomic) IBOutlet UITextField *pickerText;

@property NSArray *trackingArray;

/** common */
@property (nonatomic, strong) CoreDataStack *coreDataSrack;
- (IBAction)scan:(id)sender;
- (IBAction)cancalButton:(id)sender;
- (IBAction)SaveTracking:(id)sender;

@end

@implementation AddTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    
    carrierArray = [NSArray arrayWithObjects:@"usps",@"ups", @"fedex", nil];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    
    [picker setShowsSelectionIndicator:YES];
    [self.pickerText setInputView:picker];
    self.cancal.hidden = YES;
    
    [self requestData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"tracking"]){
        MapViewController *controller = (MapViewController *)segue.destinationViewController;
        controller.tracking = self.trackingInput.text;
        NSLog(@"controller.tracking=%@", controller.tracking);
        controller.carrierText = self.pickerText.text;
        
        NSLog(@"controller.carrierText=%@", controller.carrierText);

    }
}



- (IBAction)scan:(id)sender {
    //get carma
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //setup inuput
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //setup output
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];

    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    self.scanlayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    self.scanlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.scanlayer.frame = self.view.layer.bounds;
    
    //[self.view.layer insertSublayer: self.scanlayer atIndex:0];
    [self.view.layer addSublayer:self.scanlayer];
    [session startRunning];
    
    self.trackingInput.hidden = YES;
    self.backButton.hidden = YES;
    self.saveButton.hidden = YES;
    self.pickerText.hidden = YES;
    self.trackingLabel.hidden = YES;
    self.carriersLabel.hidden = YES;
    self.scanButton.hidden = YES;
    self.cancal.hidden = NO;
}



-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [session stopRunning];
        
        self.trackingInput.hidden = NO;
        self.backButton.hidden = NO;
        self.saveButton.hidden = NO;
        self.pickerText.hidden = NO;
        self.trackingLabel.hidden = NO;
        self.carriersLabel.hidden = NO;
        self.scanButton.hidden = NO;
        self.cancal.hidden = YES;
        
        [self.scanlayer removeFromSuperlayer];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0];
        NSLog(@"%@",metadataObject.stringValue);
        self.trackingInput.text = metadataObject.stringValue;
        
        NSString *checkCarrier = [self.trackingInput.text substringWithRange:NSMakeRange(0,1)];
        if ([checkCarrier isEqualToString:@"1"]) {
            self.pickerText.text = @"ups";
        }
        if ([checkCarrier isEqualToString:@"6"]) {
            self.pickerText.text = @"fedex";
        }
        if ([checkCarrier isEqualToString:@"9"]) {
           self.pickerText.text = @"usps";
        }
    }
}

- (IBAction)cancalButton:(id)sender {
    self.trackingInput.hidden = NO;
    self.backButton.hidden = NO;
    self.saveButton.hidden = NO;
    self.pickerText.hidden = NO;
    self.trackingLabel.hidden = NO;
    self.carriersLabel.hidden = NO;
    self.scanButton.hidden = NO;
    self.cancal.hidden = YES;
    [self.scanlayer removeFromSuperlayer];
}

- (IBAction)save {
    [SVProgressHUD show];
    
    self.coreDataSrack = [[CoreDataStack alloc] init];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"TrackNumber" inManagedObjectContext:self.coreDataSrack.managedObjectContext];
    
    self.trackingInput.text = @"1Z602F9A4246804081";
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrackNumber"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"trackingNumber = %@", @"1Z602F9A4246804081"]];
    
    NSUInteger count = [self.coreDataSrack.managedObjectContext countForFetchRequest:request error:nil];
    if (count) {
        NSLog(@"found");
    }else {
        [object setValue:self.trackingInput.text forKey:@"trackingNumber"];
        NSLog(@"save into core data");
        NSError *error;
        if ([self.coreDataSrack.managedObjectContext save:&error] == NO){
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        } else
        {
            NSLog(@"success");
        }
    }
     NSLog(@"---");

    
    NSError *error2 = nil;
    NSArray *results = [self.coreDataSrack.managedObjectContext executeFetchRequest:request error:&error2];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error2 localizedDescription], [error2 userInfo]);
        abort();
    }else {
        NSLog(@"trackingNumber = %@", results);
    }
    
    NSLog(@"----");
    NSString *t = [results valueForKey:@"trackingNumber"];
    NSLog(@"t=%@", t);
    
     NSLog(@"---");
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"https://api.goshippo.com/v1/tracks/ups/1Z602F9A4246804081" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD show];
//    
//        self.coreDataSrack = [[CoreDataStack alloc] init];
//        [SVProgressHUD dismiss];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"faile");
//    }];
    
}




//- (IBAction)SaveTracking:(id)sender {
//    [SVProgressHUD show];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"https://api.goshippo.com/v1/tracks/ups/1Z602F9A4246804081" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //self.coreDataSrack = [[CoreDataStack alloc] init];
//        
//
//        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"TrackNumber" inManagedObjectContext:self.coreDataSrack.managedObjectContext];
//        [object setValue:responseObject forKey:@"trackingData"];
//        
//        NSLog(@"----");
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TrackNumber"];
//        NSLog(@"NSFetchRequest====%@", request);
//        [SVProgressHUD dismiss];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"faile");
//    }];

//    NSString *host = @"https://api.goshippo.com/v1/tracks/";
//    NSString *carrier = self.pickerText.text;
//    NSString *trackingNumber = self.trackingInput.text;
//    NSString *url = [[[host stringByAppendingString:carrier] stringByAppendingString:@"/"] stringByAppendingString:trackingNumber];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]];
//    // NSLog(@"%@", url);
//    request.HTTPMethod = @"GET";
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSDictionary *packageFullDeatil = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        
//        NSDictionary *package = [packageFullDeatil objectForKey:@"tracking_status"];
//        //  NSLog(@"%@",[d1 objectForKey:@"status"]);
//        // NSString *status = [d1 objectForKey:@"status"];
//        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        //NSLog(@"%@", path);
//        NSString *doc = [path objectAtIndex:0];
//        NSString *paths = [doc stringByAppendingPathComponent:@"PackageList.plist"];
//        NSLog(@"paths = %@", paths);
//        if (![[NSFileManager defaultManager] fileExistsAtPath:paths]) {
//            NSMutableDictionary *packageDic = [[NSMutableDictionary alloc] init];
//            [packageDic setObject: package forKey: self.trackingInput.text];
//            [packageDic writeToFile:paths atomically:YES];
//            NSLog(@"packageDic = %@", packageDic);
//        }else{
//            
//            NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithContentsOfFile:paths];
//            NSLog(@"temp = %@", temp);
//            [temp setObject: package forKey: self.trackingInput.text];
//            [temp writeToFile:paths atomically:YES];
//        }
//    }];
//    
//    [task resume];
//}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [carrierArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [carrierArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.pickerText.text = [carrierArray objectAtIndex:row];
}


#pragma mark RESTKit

- (void)requestData
{
    NSString *requestPath = @"/v1/tracks/ups/1Z1A00R20204584514";
    [[RKObjectManager sharedManager] getObjectsAtPath:requestPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self fetchTrackInfoFromContext];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {

    }];
}


- (void)fetchTrackInfoFromContext
{
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TrackInfo"];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSInteger i = 0; i < fetchedObjects.count; i++) {
        TrackInfo *trackInfo = fetchedObjects[i];
       
 
        NSLog(@"trackInfo.tracking_number---%@", trackInfo.tracking_number);
        NSLog(@"trackInfo.carrier-----%@", trackInfo.carrier);
        NSLog(@"eta----%@", trackInfo.eta);
        NSLog(@"trackInfo.addressFrom----%@", trackInfo.addressFrom.city);
        NSLog(@"trackInfo.addressFrom----%@", trackInfo.addressFrom.country);
        NSLog(@"trackInfo.addressFrom----%@", trackInfo.addressFrom.zip);
        NSLog(@"trackInfo.addressFrom----%@", trackInfo.addressFrom.state);
    }
}


@end
