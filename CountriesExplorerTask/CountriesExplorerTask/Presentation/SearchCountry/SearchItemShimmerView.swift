//
//  SearchItemShimmerView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 07/11/2025.
//

import SwiftUI
import SwiftUI_Shimmer

struct SearchItemShimmerView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                .frame(width: 60, height: 45)
                .shimmering()

            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: 120, height: 14)
                    .shimmering()

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: 80, height: 14)
                    .shimmering()

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: 100, height: 14)
                    .shimmering()
            }
            Spacer()

            Circle()
                .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                .frame(width: 16, height: 16)
                .shimmering()
        }
        .padding(8)
        .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
        )
    }
}
