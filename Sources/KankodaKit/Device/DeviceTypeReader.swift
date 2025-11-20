//
//  DeviceTypeReader.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-03.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import LocalAuthentication
import SwiftUI

/// This protocol can be implemented by any type that needs certain device info.
public protocol DeviceTypeReader {}

public extension DeviceTypeReader {

    /// Check whether or not the device has a home button.
    var deviceHasHomeButton: Bool {
        deviceSupportsTouchId
    }

    /// Check which biometry auth type the device supports.
    var deviceSupportedBiometryType: LABiometryType {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }

    /// Check whether or not the device supports Face ID.
    var deviceSupportsFaceId: Bool {
        let type = deviceSupportedBiometryType
        return type == .faceID
    }

    /// Check whether or not the device supports Touch ID.
    var deviceSupportsTouchId: Bool {
        let type = deviceSupportedBiometryType
        return type == .touchID
    }
}
#endif
