import Foundation

typealias DTEmptyHandler = () -> Void

/// Debouncer
///
///     private var debouncer: Debouncer!
///     override func viewDidLoad() {
///         super.viewDidLoad()
///         debouncer = Debouncer.init(delay: 3, callback: debouncerApiCall)
///     }
/// 
///     private func debouncerApiCall() {
///         print("debouncer api call")
///     }
/// 
public
class DTDebouncer {

    public var callback: DTEmptyHandler
    public var delay: Double
    public weak var timer: Timer?

    public 
    init(delay: Double, callback: @escaping DTEmptyHandler) {
        self.delay = delay
        self.callback = callback
    }

    public 
    func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, 
                                             target: self, 
                                             selector: #selector(Debouncer.fireNow), 
                                             userInfo: nil, 
                                             repeats: false)
        timer = nextTimer
    }

    @objc 
    func fireNow() {
        self.callback()
    }
}