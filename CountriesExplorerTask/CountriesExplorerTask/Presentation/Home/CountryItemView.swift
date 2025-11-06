//
//  CountryItemView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI

struct CountryItemView: View {
    let onAction: (CountryItemViewAction) -> Void

    var body: some View {
        VStack(spacing: Theme.Sizes.pt6) {
            HStack {
                Image(systemName: "flag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Theme.Sizes.pt60, height: Theme.Sizes.pt45)
                    .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt8)
                    .padding(.trailing, Theme.Sizes.pt4)
                VStack(alignment: .leading) {
                    Text("Country Name")
                        .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                    
                    Text("cca2")
                        .font(.system(size: Theme.Sizes.pt12, weight: .regular, design: .default))
                        .padding(Theme.Sizes.pt4)
                        .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt4)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                    
                }.frame(width: Theme.Sizes.pt35, height: Theme.Sizes.pt35)
            }
            
            HStack(spacing: Theme.Sizes.pt4) {
                Text("Capital:")
                    .font(.system(size: Theme.Sizes.pt14, weight: .medium, design: .default))
                
                Text("City Name")
                    .font(.system(size: Theme.Sizes.pt14, weight: .regular, design: .default))
                
                Spacer()
            }
            
            HStack(spacing: Theme.Sizes.pt4) {
                Text("Currency:")
                    .font(.system(size: Theme.Sizes.pt14, weight: .medium, design: .default))
                
                Text("Currency Name")
                    .font(.system(size: Theme.Sizes.pt14, weight: .regular, design: .default))
                
                Spacer()
            }
        }.padding(Theme.Sizes.pt8)
            .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                    .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
            )
    }
}
enum CountryItemViewAction {
    case delete(String)
  // Add More actions in card
}
