#import "RCTColorView.h"

#import "generated/LibraryExampleSpec/ComponentDescriptors.h"
#import "generated/LibraryExampleSpec/EventEmitters.h"
#import "generated/LibraryExampleSpec/Props.h"
#import "generated/LibraryExampleSpec/RCTComponentViewHelpers.h"

// #import "RCTFabricComponentsPlugins.h"
// #import "FabricComponentExample-Swift.h"
#import "NativeColorView-Swift.h"

using namespace facebook::react;

template <typename PropsT> NSDictionary *convertProps(const PropsT &props) {
  // Adjust conversion per your prop structure.
  return @{@"color" : [NSString stringWithUTF8String:props.color.c_str()]};
}

@interface RCTColorView () <RCTComponentViewProtocol>

@end

@implementation RCTColorView {
  ColorView *_containerView;
  // ColorView *_view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider {
  return concreteComponentDescriptorProvider<
      NativeColorViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps =
        std::make_shared<const NativeColorViewProps>();
    _props = defaultProps;

    // _containerView = [UIView new];
    _containerView = [ColorView new];

    // Add the native view as a subview.
    // [_containerView addSubview:_view];

    // Use containerView as the contentView so it can host children.
    self.contentView = _containerView;
  }

  return self;
}

// These methods allow Fabric to pass along children.
// - (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex {
//   // Adjust index if necessary; here we assume children come after
//   _colorView.
//   [_containerView insertSubview:subview atIndex:atIndex + 1];
// }

// - (void)removeReactSubview:(UIView *)subview {
//   [subview removeFromSuperview];
// }

- (void)updateProps:(Props::Shared const &)props
           oldProps:(Props::Shared const &)oldProps {
  const auto &oldViewProps =
      *std::static_pointer_cast<NativeColorViewProps const>(oldProps ? oldProps
                                                                     : _props);
  const auto &newViewProps =
      *std::static_pointer_cast<NativeColorViewProps const>(props);
  NSDictionary *oldViewPropsDict = convertProps(oldViewProps);
  NSDictionary *newViewPropsDict = convertProps(newViewProps);

  [_containerView updatePropsWith:newViewPropsDict
                    oldDictionary:oldViewPropsDict];

  [super updateProps:props oldProps:oldProps];
}

// Class<RCTComponentViewProtocol> FabricDeclarativeViewCls(void) {
//   return RCTColorView.class;
// }

@end
