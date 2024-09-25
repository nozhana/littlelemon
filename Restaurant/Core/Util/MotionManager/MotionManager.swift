//
//  MotionManager.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/19/24.
//

import CoreMotion
import Foundation

class MotionManager: ObservableObject {
    fileprivate init() {}
    private let manager = CMMotionManager()
    
    @Published var roll = 0.0
    @Published var pitch = 0.0
    @Published var yaw = 0.0
    
    var normalizedRoll: Double {
        if roll <= (.pi / 2) && roll >= (-.pi / 2) { return roll }
        else if roll > (.pi / 2) { return .pi - roll }
        else { return -.pi - roll }
    }
    
    var normalizedYaw: Double {
        if yaw <= (.pi / 2) && yaw >= (-.pi / 2) { return roll }
        else if yaw > (.pi / 2) { return .pi - yaw }
        else { return -.pi - yaw }
    }
    
    func startMonitoringUpdates() {
        guard manager.isDeviceMotionAvailable else {
            print("CMMotion: device motion not available.")
            return
        }
        
        manager.deviceMotionUpdateInterval = 0.01
        
        manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self, let motion else { return }
            pitch = motion.attitude.pitch
            roll = motion.attitude.roll
            yaw = motion.attitude.yaw
        }
    }
}


extension Container {
    var motionManager: Factory<MotionManager> {
        self { MotionManager() }
            .unique
    }
}
