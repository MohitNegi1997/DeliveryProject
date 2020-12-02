//
//  Debouncer.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation

class Debouncer {
    
    typealias Handler = () -> Void
    private let timeInterval: TimeInterval
    private var count: Int = 0
    // handler is the closure to run when all the debouncing is done
    // in my case, this is where I sync the data to our server
    var handler: Handler? {
        didSet {
            if self.handler != nil {
                // increment count of callbacks, since each time I get a
                // callback, I update the handler
                self.count += 1
                // start a new asyncAfter call
                self.renewInterval()
            }
        }
    }
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func renewInterval() {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeInterval) {
            self.runHandler()
        }
    }
    
    private func runHandler() {
        // first, decrement count because a callback delay has finished and called runHandler
        self.count -= 1
        // only continue to run self.handler if the count is now zero
        if self.count <= 0 {
            self.handler?()
            self.handler = nil
        }
    }
}
