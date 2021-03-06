//
//  UIApplication+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIApplication+LM.h"
#import "LMKit.h"
#import <objc/runtime.h>

@import AddressBook;
@import AssetsLibrary;
@import AVFoundation;
@import CoreBluetooth;
@import CoreLocation;
@import CoreMotion;
@import EventKit;

#define kLMFirstOpenedApp @"LMFirstOpenedApp"
#define kLMFirstOpenedBuild @"LMFirstOpenedBuild"
#define kLMFirstOpenedVersion @"LMFirstOpenedVersion"

typedef void (^LocationSuccessCallback)();
typedef void (^LocationFailureCallback)();
typedef void (^LocationDidUpdateLocationsCallback)();

@interface UIApplication () <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) CLLocationManager *permissionsLocationManager;
@property (copy, nonatomic) LocationSuccessCallback locationSuccessCallbackProperty;
@property (copy, nonatomic) LocationFailureCallback locationFailureCallbackProperty;
@property (copy, nonatomic) LocationDidUpdateLocationsCallback locationDidUpdateLocations;

@end

static char PermissionsLocationManagerKey;
static char PermissionsLocationBlockSuccessKey;
static char PermissionsLocationBlockFailureKey;
static char LocationDidUpdateLocationsKey;

@implementation UIApplication (LM)

#pragma mark 是否首次打开这个应用

- (void)lm_firstOpenedApp:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:kLMFirstOpenedApp flag:block];
}

#pragma mark 是否首次打开这个build

- (void)lm_firstOpenedBuild:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:[kLMFirstOpenedBuild stringByAppendingString:LMAppBuild] flag:block];
}

#pragma mark 是否首次打开这个Version

- (void)lm_firstOpenedVersion:(void (^)(BOOL isFirstOpened))block
{
    [self lm_firstOpenedKey:[kLMFirstOpenedVersion stringByAppendingString:LMAppVersion] flag:block];
}

#pragma mark 是否首次打开

- (void)lm_firstOpenedKey:(NSString *)key flag:(void (^)(BOOL isFirstOpened))block
{
    BOOL firstOpened = LMGetUserDefaults(key).boolValue;
    
    if(!firstOpened) {
        
        LMSaveUserDefaults(@"1", key);
    }
    
    block(!firstOpened);
}

#pragma mark - RequestAccessGranted

- (void)lm_requestAccessGrantedToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusNotDetermined:
        {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        if (accessGranted) {
                            
                            accessGranted();
                        }
                        
                    } else {
                        
                        if (accessDenied) {
                            
                            accessDenied();
                        }
                    }
                });
            }];
        }
            break;
        case EKAuthorizationStatusAuthorized:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_requestAccessGrantedToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusNotDetermined:
        {
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            
            if (addressBook) {
                
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (granted) {
                            
                            if (granted) {
                                
                                accessGranted();
                            }
                            
                        } else {
                            
                            if (accessDenied) {
                                
                                accessDenied();
                            }
                        }
                    });
                });
            }
        }
            break;
        case kABAuthorizationStatusAuthorized:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case kABAuthorizationStatusRestricted:
        case kABAuthorizationStatusDenied:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_requestAccessGrantedToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    AVAudioSession *session = [[AVAudioSession alloc] init];
    
    [session requestRecordPermission:^(BOOL granted) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (granted) {
                
                if (accessGranted) {
                    
                    accessGranted();
                }
                
            } else {
                
                if (accessDenied) {
                    
                    accessDenied();
                }
            }
        });
    }];
}

- (void)lm_requestAccessGrantedToCameraWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
        case ALAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        if (accessGranted) {
                            
                            accessGranted();
                        }
                        
                    } else {
                        
                        if (accessDenied) {
                            
                            accessDenied();
                        }
                    }
                });
            }];
        }
            break;
        case ALAuthorizationStatusAuthorized:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case ALAuthorizationStatusDenied:
        case ALAuthorizationStatusRestricted:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_requestAccessGrantedToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusNotDetermined:
        {
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (accessGranted) {
                    
                    accessGranted();
                }
                
            } failureBlock:^(NSError *error) {
                
                if (accessDenied) {

                    accessDenied();
                }
            }];
        }
            break;
        case ALAuthorizationStatusAuthorized:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case ALAuthorizationStatusDenied:
        case ALAuthorizationStatusRestricted:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_requestAccessGrantedToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusNotDetermined:
        {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            
            [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        if (accessGranted) {
                            
                            accessGranted();
                        }
                        
                    } else {
                        
                        if (accessDenied) {
                            
                            accessDenied();
                        }
                    }
                });
            }];
        }
            break;
        case EKAuthorizationStatusAuthorized:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_requestAccessGrantedToMotionWithSuccess:(void(^)())accessGranted
{
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    
    [motionManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity) {
        
        if (accessGranted) {
            
            accessGranted();
        }
        
        [motionManager stopActivityUpdates];
    }];
}

- (void)lm_requestAccessGrantedToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied
{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if (!self.permissionsLocationManager) {
                
                self.permissionsLocationManager = [[CLLocationManager alloc] init];
                self.permissionsLocationManager.delegate = self;
            }
            
            if (LMiOS8) {
                [self.permissionsLocationManager requestWhenInUseAuthorization];
            } else {
                [self.permissionsLocationManager startUpdatingLocation];
                self.locationDidUpdateLocations = nil;
            }
            
            self.locationSuccessCallbackProperty = accessGranted;
            self.locationFailureCallbackProperty = accessDenied;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            if (accessGranted) {
                
                accessGranted();
            }
        }
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            if (accessDenied) {
                
                accessDenied();
            }
        }
            break;
        default:
            break;
    }
}

- (void)lm_locationDidUpdate:(void (^)(NSArray *, NSError *))didUpdateLocations
{
    if (!self.permissionsLocationManager) {
        
        self.permissionsLocationManager = [[CLLocationManager alloc] init];
        self.permissionsLocationManager.delegate = self;
    }
    
    [self.permissionsLocationManager startUpdatingLocation];
    
    self.locationDidUpdateLocations = didUpdateLocations;
}

- (void)lm_showGrantedAccessDeniedWithType:(NSString *)type title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    if (LMiOS8) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"请在系统设置中，打开\"隐私-%@\"，并允许%@使用%@", type, LMAppName, type] delegate:self cancelButtonTitle:cancelButtonTitle ? cancelButtonTitle : @"确定" otherButtonTitles:@"设置", nil];
        [alertView show];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"请在系统设置中，打开\"隐私-%@\"，并允许%@使用%@", type, LMAppName, type] delegate:self cancelButtonTitle:cancelButtonTitle ? cancelButtonTitle : @"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - -.-

- (CLLocationManager *)permissionsLocationManager {
    
    return objc_getAssociatedObject(self, &PermissionsLocationManagerKey);
}

- (void)setPermissionsLocationManager:(CLLocationManager *)manager {
    
    objc_setAssociatedObject(self, &PermissionsLocationManagerKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LocationSuccessCallback)locationSuccessCallbackProperty {
    
    return objc_getAssociatedObject(self, &PermissionsLocationBlockSuccessKey);
}

- (void)setLocationSuccessCallbackProperty:(LocationSuccessCallback)locationCallbackProperty {
    
    objc_setAssociatedObject(self, &PermissionsLocationBlockSuccessKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LocationFailureCallback)locationFailureCallbackProperty {
    
    return objc_getAssociatedObject(self, &PermissionsLocationBlockFailureKey);
}

- (void)setLocationFailureCallbackProperty:(LocationFailureCallback)locationFailureCallbackProperty {
    
    objc_setAssociatedObject(self, &PermissionsLocationBlockFailureKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LocationDidUpdateLocationsCallback)locationDidUpdateLocations {
    
    return objc_getAssociatedObject(self, &LocationDidUpdateLocationsKey);
}

- (void)setLocationDidUpdateLocations:(LocationDidUpdateLocationsCallback)locationDidUpdateLocations {
    
    objc_setAssociatedObject(self, &LocationDidUpdateLocationsKey, locationDidUpdateLocations, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (LMiOS8) {
        
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            if (self.locationSuccessCallbackProperty) {
                self.locationSuccessCallbackProperty();
            }
        } else if (status != kCLAuthorizationStatusNotDetermined) {
            if (self.locationFailureCallbackProperty) {
                self.locationFailureCallbackProperty();
            }
        }
        
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        if (status == kCLAuthorizationStatusAuthorized) {
#pragma clang diagnostic pop
            if (self.locationSuccessCallbackProperty) {
                self.locationSuccessCallbackProperty();
            }
        } else if (status != kCLAuthorizationStatusNotDetermined) {
            if (self.locationFailureCallbackProperty) {
                self.locationFailureCallbackProperty();
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if (self.locationDidUpdateLocations) {
        
        self.locationDidUpdateLocations(nil, error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (locations && self.locationDidUpdateLocations) {
        
        self.locationDidUpdateLocations(locations, nil);
    }
    
    [self.permissionsLocationManager stopUpdatingLocation];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark -

#pragma mark 打电话

- (BOOL)lm_callTelephone:(NSString *)tel
{
    if (!tel.length) {
        
        return FALSE;
    }
    
    return [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:%@", tel]]];
}

#pragma mark 跳转到appStroe应用详情

- (BOOL)lm_openAppDetailsURLForIdentifier:(NSUInteger)identifier
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier]]];
}


#pragma mark 跳转到appStroe应用评论

- (BOOL)lm_openAppReviewsURLForIdentifier:(NSUInteger)identifier
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%li", (long)identifier]]];
}

#pragma mark 跳转到App

- (BOOL)lm_openAppForURLSchemes:(NSString *)schemes
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:schemes]];
}

@end
