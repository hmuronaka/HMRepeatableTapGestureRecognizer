//
//  HMRepeatableTapGestureRecognizer.swift
//
//  Created by Hiroaki Muronaka on 2021/10/08.
//
import UIKit
import UIKit.UIGestureRecognizerSubclass
import HMTargetActionList

/// Viewを押し続けると連続して.changeイベントを発火するGestureRecognizer
///
/// USAGE
///
/// ```swift
/// let gesture = HMRepeatableGestureRecognizer() { _ in
///    // NOTE gesture.stateは参照しないこと。
///    NSLog("event fired")
/// }
/// self.button.addGesture(gesture)
/// ```
///
/// UIGestureRecognizerはtouchMovedをoverrideしたとしてもtouchMovedが発生したときに.changedイベントが発火されるため、
/// UIGestureRecognizer.stateは利用しない実装としている。
open class HMRepeatableTapGestureRecognizer: UIGestureRecognizer {
    
    //MARK: public attributes
    
    public typealias Action = (HMRepeatableTapGestureRecognizer) -> ()
    
    /// リピートが始まるまでの間隔(seconds)
    public let minimumPressDuration: TimeInterval
    
    /// リピート間隔(seconds)
    public let repeatInterval: TimeInterval
    
    public let numberOfTouchsRequired: Int
    
    /// 発火するアクション
    public let action: Action?
    
    //MARK: private attributes
    /// リピートするまでの待機用タイマ
    private var longPressTimer: Timer?
    
    /// リピートタイマ
    private var repeatActionTimer: Timer?
    
    /// タッチ数
    private var currentTouchsCount = 0
    
    private var targetActionList: HMTargetActionList = HMTargetActionList()
    
    //MARK: constructors
    
    /// gestureを生成する
    /// - Parameters:
    ///   - minimumPressDuration: minimumPressDuration description
    ///   - repeatInterval: repeatInterval description
    ///   - numberOfTouchRequired: numberOfTouchRequired description
    ///   - action: action description
    public init(minimumPressDuration: TimeInterval = 0.5, repeatInterval: TimeInterval = 0.2, numberOfTouchRequired: Int = 1, action: Action? = nil) {
        
        self.minimumPressDuration = minimumPressDuration
        self.repeatInterval = repeatInterval
        self.numberOfTouchsRequired = numberOfTouchRequired
        self.action = action
        
        super.init(target: nil, action: nil)
    }
}

//MARK: implementations
extension HMRepeatableTapGestureRecognizer {
   
    private func cancelTimers() {
        self.repeatActionTimer?.invalidate()
        self.longPressTimer?.invalidate()
        self.repeatActionTimer = nil
        self.longPressTimer = nil
    }
    
    private func startRepeatTimer() {
        guard self.repeatInterval > 0 else {
            return
        }
        self.repeatActionTimer = Timer.scheduledTimer(withTimeInterval: self.repeatInterval, repeats: true, block: { _ in
            self.fireAction()
        })
    }
    
    private func fireAction() {
        self.state = .changed
        self.action?(self)
        self.targetActionList.fire(self)
    }
}
//MARK: override methods
extension HMRepeatableTapGestureRecognizer {
    
    open override func addTarget(_ target: Any, action: Selector) {
        self.targetActionList.addTarget(target as AnyObject, action: action)
    }
    
    open override func removeTarget(_ target: Any?, action: Selector?) {
        if let target = target {
            if let action = action {
                self.targetActionList.removeTarget(target as AnyObject, action: action)
            } else {
                self.targetActionList.removeActions(target as AnyObject)
            }
        }
    }
    
    open override func reset() {
        self.currentTouchsCount = 0
        self.cancelTimers()
        super.reset()
    }
     
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        self.currentTouchsCount += touches.count
        guard self.currentTouchsCount == self.numberOfTouchsRequired else {
            if self.currentTouchsCount > self.numberOfTouchsRequired {
                self.state = (self.state == .possible ? .failed : .cancelled)
            }
            return
        }
        
        super.touchesBegan(touches, with: event)
        
        if self.minimumPressDuration > 0 {
            self.longPressTimer = Timer.scheduledTimer(withTimeInterval: self.minimumPressDuration, repeats: false, block: { _ in
                self.startRepeatTimer()
            })
        } else {
            self.startRepeatTimer()
        }
        self.state = .began
        self.fireAction()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.state = .cancelled
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = .ended
    }
   
}
