//
//  CircularGestureViewController.m
//

#import "OneFingerRotationGestureViewController.h"

@interface OneFingerRotationGestureViewController ()
{
@private CGFloat imageAngle;
@private OneFingerRotationGestureRecognizer *gestureRecognizer;
}

- (void) updateTextDisplay;
- (void) setupGestureRecognizer;
@end

@implementation OneFingerRotationGestureViewController

@synthesize image;
@synthesize textDisplay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        // Custom initialization
        imageAngle = 0;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupGestureRecognizer];
    [self updateTextDisplay];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    image = nil;
    textDisplay = nil;
    gestureRecognizer = nil;
}

#pragma mark - UIViewController methods 

// Any rotation is supported.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// To make things easier, the gesture recognizer is removed before rotation...
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
                                 duration: (NSTimeInterval) duration
{
    [self.view removeGestureRecognizer: gestureRecognizer];

    // improvement opportunity: translate the rotation angle
    imageAngle = 0;
    image.transform = CGAffineTransformIdentity;
}

// ... and added afterwards.
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupGestureRecognizer];
    [self updateTextDisplay];
}

#pragma mark - CircularGestureRecognizerDelegate protocol

- (void) rotation: (CGFloat) angle
{
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < -360)
        imageAngle += 360;
    
    // rotate image and update text field
    image.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    [self updateTextDisplay];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
    [self updateTextDisplay];
}

#pragma mark - Helper methods

// Updates the text field with the current rotation angle.
- (void) updateTextDisplay
{
    textDisplay.text = [NSString stringWithFormat: @"\u03b1 = %.2f", imageAngle];
}

// Addes gesture recognizer to the view (or any other parent view of image. Calculates midPoint
// and radius, based on the image position and dimension.
- (void) setupGestureRecognizer
{
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(image.frame.origin.x + image.frame.size.width / 2,
                                   image.frame.origin.y + image.frame.size.height / 2);
    CGFloat outRadius = image.frame.size.width / 2;
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange 
    // effects when touching the control near of it's center
    gestureRecognizer = [[OneFingerRotationGestureRecognizer alloc] initWithMidPoint: midPoint
                                                                innerRadius: outRadius / 3 
                                                                outerRadius: outRadius
                                                                     target: self];
    [self.view addGestureRecognizer: gestureRecognizer];
}
@end
