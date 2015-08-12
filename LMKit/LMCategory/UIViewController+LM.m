//
//  UIViewController+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIViewController+LM.h"
#import <objc/runtime.h>

@import StoreKit;

@interface UIViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SKStoreProductViewControllerDelegate>

@property (copy, nonatomic) LMFinishPickingMedia finishPickingMedia;

@property (copy, nonatomic) LMCancelPickingMedia cancelPickingMedia;

@property (copy, nonatomic) LMDidFinishAppStore didFinishAppStore;

@end

static char finishPickingMediaKey, cancelPickingMediaKey, didFinishAppStoreKey, segueDictionaryKey;

@implementation UIViewController (LM)

#pragma mark -.-

- (void)setFinishPickingMedia:(LMFinishPickingMedia)finishPickingMedia {
    
    objc_setAssociatedObject(self, &finishPickingMediaKey, finishPickingMedia, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMFinishPickingMedia)finishPickingMedia {
    
    return objc_getAssociatedObject(self, &finishPickingMediaKey);
}

- (void)setCancelPickingMedia:(LMCancelPickingMedia)cancelPickingMedia {
    
    objc_setAssociatedObject(self, &cancelPickingMediaKey, cancelPickingMedia, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMCancelPickingMedia)cancelPickingMedia {
    
    return objc_getAssociatedObject(self, &cancelPickingMediaKey);
}

- (void)setDidFinishAppStore:(LMDidFinishAppStore)didFinishAppStore {
    
    return objc_setAssociatedObject(self, &didFinishAppStoreKey, didFinishAppStore, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMDidFinishAppStore)didFinishAppStore {
    
    return objc_getAssociatedObject(self, &didFinishAppStoreKey);
}

- (NSMutableDictionary *)segueDictionary {
    
    return objc_getAssociatedObject(self, &segueDictionaryKey);
}

- (NSMutableDictionary *)setSegueDictionary {
    
    if (!self.segueDictionary) {
        
        objc_setAssociatedObject(self, &segueDictionaryKey, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self.segueDictionary;
}

#pragma mark 触摸自动隐藏键盘

- (void)lm_tapDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lm_tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view addGestureRecognizer:singleTapGR];
    }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        [weakSelf.view removeGestureRecognizer:singleTapGR];
    }];
}

- (void)lm_tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark 转场动画

- (void)lm_addTransitionType:(LMTransitionType)type direction:(LMTransitionDirection)direction duration:(NSTimeInterval)duration completion:(LMTransitionCompletion)completion
{
    CATransition *animation = [CATransition animation];
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    switch (type) {
        case LMTransitionTypeFade:
            animation.type = kCATransitionFade;
            break;
        case LMTransitionTypePush:
            animation.type = kCATransitionPush;
            break;
        case LMTransitionTypeCube:
            animation.type = @"cube";
            break;
        case LMTransitionTypeFlip:
            animation.type = @"oglFlip";
            break;
        case LMTransitionTypeRipple:
            animation.type = @"rippleEffect";
            break;
        case LMTransitionTypePageCurl:
            animation.type = @"pageCurl";
            break;
        case LMTransitionTypePageUnCurl:
            animation.type = @"pageUnCurl";
            break;
        case LMTransitionTypePageCameraOpen:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case LMTransitionTypePageCamreaClose:
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    
    switch (direction) {
        case LMTransitionDirectionTop:
            animation.subtype = kCATransitionFromTop;
            break;
        case LMTransitionDirectionLeft:
            animation.subtype = kCATransitionFromLeft;
            break;
        case LMTransitionDirectionBottom:
            animation.subtype = kCATransitionFromBottom;
            break;
        case LMTransitionDirectionRight:
            animation.subtype = kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
    
    if (completion) {
        completion();
    }
}

#pragma mark -.-

- (UIImagePickerController *)lm_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing completion:(void (^)(void))completion didFinishPickingMedia:(LMFinishPickingMedia)finishPickingMedia didCancelPickingMediaWithInfo:(LMCancelPickingMedia)cancelPickingMedia
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        if (![UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
#ifdef DEBUG
            NSLog(@"没有检测到摄像头");
#endif
            return nil;
        }
    }
    
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    [pickController setSourceType:sourceType];
    [pickController setDelegate:self];
    [pickController setAllowsEditing:allowsEditing];
    
    [self presentViewController:pickController animated:YES completion:completion];
    
    self.finishPickingMedia = finishPickingMedia;
    self.cancelPickingMedia = cancelPickingMedia;
    
    return pickController;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        if (self.finishPickingMedia) {
            self.finishPickingMedia(info);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        if (self.cancelPickingMedia) {
            self.cancelPickingMedia();
        }
    }];
}

#pragma mark - 跳转到SKStoreProductViewController

- (void)lm_presentAppStoreWithITunesItemIdentifier:(NSInteger)itemIdentifier loading:(LMLoadingAppStore)loadingAppStore loaded:(LMLoadedAppStore)loadedAppStore didFinish:(LMDidFinishAppStore)didFinishAppStore
{
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier: @(itemIdentifier), @"at": @"ct"};
    
    if (loadingAppStore) {
        
        loadingAppStore();
    }
    
    if (didFinishAppStore) {
        
        self.didFinishAppStore = didFinishAppStore;
    }
    
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        
        if (loadedAppStore) {
            
            loadedAppStore(error);
        }
        
        if (result && !error) {
            
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

#pragma mark SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    if (self.didFinishAppStore) {
        
        self.didFinishAppStore();
    }
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - StoryboardSegue

- (void)lm_prepareForSegueWithIdentifier:(NSString *)identifier storyboardSegue:(LMStoryboardSegue)storyboardSegue
{
    if (!identifier) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }
    
    if (!storyboardSegue) {
        
        return ;
    }
    
    NSMutableDictionary *segueDictionary = self.segueDictionary ?: [self setSegueDictionary];
    
    [segueDictionary setObject:storyboardSegue forKey:identifier];
}

- (void)lm_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender storyboardSegue:(LMStoryboardSegue)storyboardSegue
{
    if (!identifier) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Segue identifier can not be nil" userInfo:nil];
    }
    
    if (!storyboardSegue) {
        
        [self performSegueWithIdentifier:identifier sender:sender];
        
        return ;
    }
    
    [self lm_prepareForSegueWithIdentifier:identifier storyboardSegue:storyboardSegue];
    
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (!segue.identifier.length) {
        
        return;
    }
    
    if (!self.segueDictionary || !self.segueDictionary[segue.identifier]) {
        
        return;
    }
    
    LMStoryboardSegue segueBlock = self.segueDictionary[segue.identifier];
    segueBlock(sender, segue, segue.destinationViewController);
}

__attribute__((constructor))
void LM(void) {
    
    Class currentClass = [UIViewController class];
    
    SEL originalSel = @selector(prepareForSegue:sender:);
    SEL swizzledSel = @selector(_prepareForSegue:sender:);
    
    Method originalMethod = class_getInstanceMethod(currentClass, originalSel);
    IMP swizzledImplementation = class_getMethodImplementation(currentClass, swizzledSel);
    
    method_setImplementation(originalMethod, swizzledImplementation);
}

#pragma mark - 当前ViewController

+ (UIViewController *)lm_currentViewController
{
    UIViewController *topViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        
        topViewController = ((UITabBarController *)topViewController).selectedViewController;
    }
    
    if ([topViewController presentedViewController]) {
        
        topViewController = [topViewController presentedViewController];
    }
    
    if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)topViewController topViewController]) {
        
        return [(UINavigationController*)topViewController topViewController];
    }
    
    return topViewController;
}

@end

@interface UINavigationController () <UINavigationBarDelegate>

@end

@implementation UINavigationController (ShouldPopOnBackButton)

/**
 *  感谢https://github.com/onegray/UIViewController-BackButtonHandler
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    if (self.viewControllers.count < navigationBar.items.count) {
        
        return YES;
    }
    
    BOOL shouldPop = YES;
    
    UIViewController *viewController = self.topViewController;
    
    if ([viewController respondsToSelector:@selector(lm_navigationShouldPopOnBackButton)]) {
        
        shouldPop = [viewController lm_navigationShouldPopOnBackButton];
    }
    
    if (shouldPop) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        
    } else {
        
        for (UIView *subView in [navigationBar subviews]) {
            
            if (subView.alpha < 1.0) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    subView.alpha = 1.0;
                }];
            }
        }
    }
    
    return NO;
}

@end
