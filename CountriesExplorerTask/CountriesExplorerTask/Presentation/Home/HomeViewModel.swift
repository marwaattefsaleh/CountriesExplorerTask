//
//  HomeViewModel.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import Combine
import Foundation
import SwiftUI
import FirebaseCrashlytics
@MainActor
final class HomeViewModel: ObservableObject {
    @Published var showToast: Bool = false
    @Published var isLoading: Bool = false
    private let router: HomeRouterProtocol
    private let networkMonitor: NetworkMonitorProtocol
    var toastMessage: String = ""

    init(router: HomeRouterProtocol, networkMonitor: NetworkMonitorProtocol) {
        self.router = router
        self.networkMonitor = networkMonitor
    }
}
