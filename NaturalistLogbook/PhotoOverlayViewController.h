//
//  PhotoOverlayViewController.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 02/08/13.
//
//

#import <UIKit/UIKit.h>

@protocol PhotoOverlayViewControllerDelegate
-(void) PhotoOverlayViewControllerDelegateAnimals ;
-(void) PhotoOverlayViewControllerDelegateMarks;
-(void) PhotoOverlayViewControllerDelegateTrails ;
-(void) PhotoOverlayViewControllerDelegateCancel ;
@end

@interface PhotoOverlayViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
}

@property (nonatomic, assign) id <PhotoOverlayViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;


- (IBAction)animalsAction:(id)sender;
- (IBAction)trailsAction:(id)sender;
- (IBAction)marksAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end


