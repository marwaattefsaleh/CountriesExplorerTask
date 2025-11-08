//
//  UIApplicationExtension.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
