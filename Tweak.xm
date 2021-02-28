#import <UIKit/UIKit.h>
#import "Headers.h"


SBFloatingDockPlatterView *floatingDockView;
SBDockView *stockDockView;
UIView *dockView;


// https://github.com/LacertosusRepo/Open-Source-Tweaks/blob/master/Navale/Tweak.x

%hook SBDockView

-(id)initWithDockListView:(id)arg1 forSnapshot:(BOOL)arg2 {
  return stockDockView = %orig;
}


-(void)didMoveToWindow {
  %orig;

  if(!dockView) {
    UIView *backgroundView = [self valueForKey:@"backgroundView"];

    dockView = [[UIView alloc] init];
    NSData *decodedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"dockColour"];
    UIColor *dockBGColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData) {
      dockView.backgroundColor = dockBGColour;
    } else {
      dockView.backgroundColor = UIColor.whiteColor;
    }

    [backgroundView addSubview:dockView];
  }

}


-(void)layoutSubviews {
  %orig;

  UIView *backgroundView = [self valueForKey:@"backgroundView"];
  if([backgroundView respondsToSelector:@selector(_materialLayer)]) {
    ((MTMaterialView *)backgroundView).weighting = 0;
    dockView.layer.cornerRadius = ((MTMaterialView *)backgroundView).materialLayer.cornerRadius;
  }
  if([backgroundView respondsToSelector:@selector(blurView)]) {
    ((SBWallpaperEffectView *)backgroundView).blurView.hidden = YES;
  }

  dockView.frame = backgroundView.bounds;

  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];

}


%new
-(void)tapGestureFired {

  if (@available(iOS 14.0, *)) {
    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    colourPickerVC.selectedColor = dockView.backgroundColor;
    [[%c(SBIconController) sharedInstance] presentViewController:colourPickerVC animated:YES completion:nil];
  }
}


%new
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *dockBGColour = viewController.selectedColor;

  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockBGColour];
  [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"dockColour"];

  dockView.backgroundColor = dockBGColour;
}


%new
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{

  UIColor *dockBGColour = viewController.selectedColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockBGColour];
  [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"dockColour"];
  dockView.backgroundColor = dockBGColour;

}

%end


%hook SBFloatingDockPlatterView

-(id)initWithFrame:(CGRect)arg1 {
  return floatingDockView = %orig;
}


-(void)layoutSubviews {
  %orig;

  _UIBackdropView *backgroundView = [self valueForKey:@"_backgroundView"];
  if(![[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){13, 0, 0}]) {
    backgroundView.backdropEffectView.hidden = YES;
  }

  if(!dockView) {

    dockView = [[UIView alloc] init];
    NSData *decodedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"dockColour"];
    UIColor *dockBGColour = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    if (decodedData) {
      dockView.backgroundColor = dockBGColour;
    } else {
      dockView.backgroundColor = UIColor.whiteColor;
    }

    [backgroundView addSubview:dockView];
  }

  dockView.frame = backgroundView.bounds;

  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureFired)];
  tapGesture.numberOfTapsRequired = 2;
  [self addGestureRecognizer:tapGesture];
}


%new
-(void)tapGestureFired {

  if (@available(iOS 14.0, *)) {
    UIColorPickerViewController *colourPickerVC = [[UIColorPickerViewController alloc] init];
    colourPickerVC.delegate = self;
    colourPickerVC.selectedColor = dockView.backgroundColor;
    [[%c(SBIconController) sharedInstance] presentViewController:colourPickerVC animated:YES completion:nil];
  }
}


%new
- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController{

  UIColor *dockBGColour = viewController.selectedColor;

  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockBGColour];
  [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"dockColour"];

  dockView.backgroundColor = dockBGColour;
}


%new
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController{

  UIColor *dockBGColour = viewController.selectedColor;
  NSData *encodedData =[NSKeyedArchiver archivedDataWithRootObject:dockBGColour];
  [[NSUserDefaults standardUserDefaults] setObject:encodedData forKey:@"dockColour"];
  dockView.backgroundColor = dockBGColour;

}

%end
