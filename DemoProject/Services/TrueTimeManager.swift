//
//  TrueTimeManager.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import TrueTime

class TrueTimeManager {
    
    public var currentTime: Date {
        serialQueue.sync{
            if let safeReferencetime = referenceTime {
                return safeReferencetime.now()
            }
            return Date()
        }
    }
    
    fileprivate let serialQueue = DispatchQueue(label: "com.trueTime.Serial.queue",
    qos: .default,
    attributes: .concurrent)
    fileprivate var referenceTime: ReferenceTime?
    fileprivate var timer: Timer?
    
    static let _shared = TrueTimeManager()
    
    static var shared: TrueTimeManager {
        return ._shared
    }
    
    private init() { }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Start the timer
    public func startTrueTime() {
        TrueTimeClient.sharedInstance.start()
        self.refreshReferenceTime()
        //self.registerApplicationStatusNotification()
    }
    
    public func refreshReferenceTime() {
        TrueTimeClient.sharedInstance.fetchIfNeeded { result in
            switch result {
            case let .success(referenceTime):
                self.serialQueue.async(flags: .barrier) {
                    self.referenceTime = referenceTime
                }

                print_debug("Got network time! \(referenceTime)")
            case let .failure(error):
                print_debug("Error! \(error)")
            }
        }
    }
    
    private func registerApplicationStatusNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startTimer),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cancelTimer),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc func startTimer() {
        self.refreshReferenceTime()
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    @objc func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func tick() {
        if let referenceTime = referenceTime {
            let trueTime = referenceTime.now()
            print_debug(trueTime)
        }
    }
    
}
