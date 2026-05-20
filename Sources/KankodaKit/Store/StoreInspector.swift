//
//  StoreInspector.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2026-05-20.
//  Copyright © 2026 Kankoda. All rights reserved.
//

import Foundation
import StoreKitPlus

public protocol StoreInspector {

    var storeContext: StoreContext { get }
}
