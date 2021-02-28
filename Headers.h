@interface SBDockView : UIView <UIColorPickerViewControllerDelegate>
@end

@interface SBFloatingDockPlatterView : UIView <UIColorPickerViewControllerDelegate>
-(double)maximumContinuousCornerRadius;
@end

@interface SBWallpaperEffectView : UIView
@property (nonatomic,retain) UIView * blurView;
@end

@interface MTMaterialLayer : CALayer
@end

@interface MTMaterialView : UIView
@property (getter=_materialLayer,nonatomic,readonly) MTMaterialLayer *materialLayer;
@property (assign, nonatomic) double weighting;
@end

@interface _UIBackdropEffectView : UIView
@end

@interface _UIBackdropView : UIView
@property (nonatomic, retain) _UIBackdropEffectView * backdropEffectView;
-(double)_cornerRadius;
@end

@interface SBIconController : UIViewController
+(id)sharedInstance;
@end
