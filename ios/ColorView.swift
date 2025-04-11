import Combine
import UIKit

// MARK: - Props

class ColorViewProps: ObservableObject {
  @Published var color: String = ""

  /// Updates the props using a dictionary and returns true if the value changed.
  @discardableResult
  func update(with dictionary: [String: Any]) -> Bool {
    let newColor = dictionary["color"] as? String ?? ""
    guard newColor != color else { return false }
    color = newColor
    return true
  }
}

private func hexStringToColor(_ stringToConvert: String) -> UIColor? {
  let noHashString = stringToConvert.replacingOccurrences(of: "#", with: "")
  guard let hex = Int(noHashString, radix: 16) else { return nil }
  let r = CGFloat((hex >> 16) & 0xFF) / 255.0
  let g = CGFloat((hex >> 8) & 0xFF) / 255.0
  let b = CGFloat(hex & 0xFF) / 255.0
  return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

// MARK: - ColorView

@objc(ColorView)
public class ColorView: UIView {
  private let contentView: UIView
  private var props: ColorViewProps
  private var cancellable: AnyCancellable?

  override init(frame: CGRect) {
    contentView = UIView()
    props = ColorViewProps() // default props
    super.init(frame: frame)
    addSubview(contentView)

    // This is the key part: make sure the contentView doesn't clip subviews
    contentView.clipsToBounds = false

    // Subscribe to changes in props.color.
    cancellable = props.$color.sink { [weak self] newColor in
      guard let updatedColor = hexStringToColor(newColor) else { return }
      DispatchQueue.main.async {
        print("backgroundColor changed")
        self?.contentView.backgroundColor = updatedColor
      }
    }

    // Add tap gesture recognizer directly in Swift.
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    addGestureRecognizer(tapGesture)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
  }

  @objc
  public func updateProps(with newDictionary: [String: Any], oldDictionary _: [String: Any]) {
    _ = props.update(with: newDictionary)
  }

  // Handle the tap gesture directly in Swift.
  @objc
  public func handleTap() {
    print("ColorView tapped")
  }

  // Methods to handle React Native children
  @objc
  public func addSubview(_ subview: UIView, at index: NSInteger) {
    contentView.insertSubview(subview, at: index)
  }

  @objc
  public func removeReactSubview(_ subview: UIView) {
    subview.removeFromSuperview()
  }
}
