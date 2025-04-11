#import "RCTColorView.h"

#import "generated/LibraryExampleSpec/ComponentDescriptors.h"
#import "generated/LibraryExampleSpec/EventEmitters.h"
#import "generated/LibraryExampleSpec/Props.h"
#import "generated/LibraryExampleSpec/RCTComponentViewHelpers.h"

#import "NativeColorView-Swift.h"

using namespace facebook::react;

@interface RCTColorView () <RCTComponentViewProtocol, RCTNativeColorViewViewProtocol>
@end

template <typename PropsT> NSDictionary *convertProps(const PropsT &props) {
  // Adjust conversion per your prop structure.
  return @{@"color" : [NSString stringWithUTF8String:props.color.c_str()]};
}

@implementation RCTColorView {
  boolean_t _isInWindow;
  ColorView *_containerView;
}

// Support RCT_DYNAMIC_FRAMEWORKS
// (https://github.com/facebook/react-native/pull/37274)
+ (void)load {
  [super load];
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps =
        std::make_shared<const NativeColorViewProps>();
    _props = defaultProps;

    _containerView = [ColorView new];

    // Set up onChange callback
    __weak RCTColorView *weakSelf = self;
    _containerView.onTap = ^() {
      NSLog(@"UIOnTap");
      __strong RCTColorView *strongSelf = weakSelf;
      if (strongSelf) {
        [strongSelf emitEvent:@"onTap"];
      }
    };

    // Use containerView as the contentView so it can host children.
    self.contentView = _containerView;
  }

  return self;
}

// MARK: - React Native Props Management

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

// MARK: - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider {
  return concreteComponentDescriptorProvider<
      NativeColorViewComponentDescriptor>();
}

// MARK: - UIView Lifecycle

- (void)didMoveToWindow {
  [super didMoveToWindow];
  _isInWindow = (self.window != nil);
}

// MARK: - React Native Subview Management (optional)

- (void)mountChildComponentView:
            (UIView<RCTComponentViewProtocol> *)childComponentView
                          index:(NSInteger)index {
  [_containerView addSubview:childComponentView at:index];
}

- (void)unmountChildComponentView:
            (UIView<RCTComponentViewProtocol> *)childComponentView
                            index:(NSInteger)index {
  [_containerView removeReactSubview:childComponentView];
}

// MARK: - Event Emitter (optional)

- (void)emitEvent:(NSString *)name {
  // Check if the view is in the window hierarchy
  if (!_isInWindow) {
    return;
  }

  NativeColorViewEventEmitter::OnTap event = {};
  self.eventEmitter.onTap(event);
}

- (const NativeColorViewEventEmitter &)eventEmitter {
  return static_cast<const NativeColorViewEventEmitter &>(*_eventEmitter);
}

@end
