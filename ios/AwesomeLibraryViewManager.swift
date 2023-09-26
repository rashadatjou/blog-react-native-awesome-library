import FlowplayerSDK

@objc(AwesomeLibraryViewManager)
class AwesomeLibraryViewManager: RCTViewManager {
  override func view() -> (AwesomeLibraryView) {
    Flowplayer.current.configure()
    return AwesomeLibraryView()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}

class AwesomeLibraryView: UIView {
  // - Views
  private let flowplayerView = FlowplayerView()

  // - Props
  @objc
  var color: String = "" {
    didSet {
      backgroundColor = hexStringToUIColor(hexColor: color)
    }
  }

  // - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  // - Helpers
  func hexStringToUIColor(hexColor: String) -> UIColor {
    let stringScanner = Scanner(string: hexColor)

    if hexColor.hasPrefix("#") {
      stringScanner.scanLocation = 1
    }
    var color: UInt32 = 0
    stringScanner.scanHexInt32(&color)

    let r = CGFloat(Int(color >> 16) & 0x0000_00FF)
    let g = CGFloat(Int(color >> 8) & 0x0000_00FF)
    let b = CGFloat(Int(color) & 0x0000_00FF)

    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
  }

  private func commonInit() {
    addSubview(flowplayerView)
    flowplayerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      flowplayerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      flowplayerView.topAnchor.constraint(equalTo: topAnchor),
      flowplayerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      flowplayerView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
