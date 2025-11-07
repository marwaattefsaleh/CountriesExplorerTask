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
            RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                .frame(width: Theme.Sizes.pt60, height: Theme.Sizes.pt45)
                .shimmering()

            VStack(alignment: .leading, spacing: Theme.Sizes.pt6) {
                RoundedRectangle(cornerRadius: Theme.Sizes.pt4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: Theme.Sizes.pt120, height: Theme.Sizes.pt14)
                    .shimmering()

                RoundedRectangle(cornerRadius: Theme.Sizes.pt4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: Theme.Sizes.pt80, height: Theme.Sizes.pt14)
                    .shimmering()

                RoundedRectangle(cornerRadius: Theme.Sizes.pt4)
                    .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                    .frame(width: Theme.Sizes.pt100, height: Theme.Sizes.pt14)
                    .shimmering()
            }
            Spacer()

            Circle()
                .fill(Color(hex: Theme.Colors.color8E8E93).opacity(0.3))
                .frame(width: Theme.Sizes.pt16, height: Theme.Sizes.pt16)
                .shimmering()
        }
        .padding(Theme.Sizes.pt8)
        .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
        )
    }
}
