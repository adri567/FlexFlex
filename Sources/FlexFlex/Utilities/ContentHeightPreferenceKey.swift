//
//  ContentHeightPreferenceKey.swift
//  
//
//  Created by Adrian Suthold on 19.07.22.
//

import Foundation
import SwiftUI

struct ContentHeightPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

