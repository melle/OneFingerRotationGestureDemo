//
//  AppDelegate.m
//  CircularGestureDemo
//

#import "AppDelegate.h"
#import "OneFingerRotationGestureViewController.h"

@implementation AppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    OneFingerRotationGestureViewController *controller = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        controller = [[OneFingerRotationGestureViewController alloc] initWithNibName:@"OneFingerRotationGestureViewController_ipad" bundle:nil];
    else
        controller = [[OneFingerRotationGestureViewController alloc] initWithNibName:@"OneFingerRotationGestureViewController_iphone" bundle:nil];

    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
