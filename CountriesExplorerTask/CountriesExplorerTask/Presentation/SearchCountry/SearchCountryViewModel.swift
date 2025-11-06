//
//  SearchCountryViewModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Combine
import Foundation
import SwiftUI
import FirebaseCrashlytics
@MainActor
final class SearchCountryViewModel: ObservableObject {
    @Published var showToast: Bool = false
    @Published var isLoading: Bool = false
    private let networkMonitor: NetworkMonitorProtocol
    var toastMessage: String = ""

    init(networkMonitor: NetworkMonitorProtocol) {
        self.networkMonitor = networkMonitor
    }
}

