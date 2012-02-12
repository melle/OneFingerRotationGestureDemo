//
//  CircularGestureViewController.h
//

#import <UIKit/UIKit.h>

#import "OneFingerRotationGestureRecognizer.h"

@interface OneFingerRotationGestureViewController : UIViewController <OneFingerRotationGestureRecognizerDelegate>
@property  (nonatomic, strong) IBOutlet UIImageView *image;
@property  (nonatomic, strong) IBOutlet UITextField *textDisplay;
@end
