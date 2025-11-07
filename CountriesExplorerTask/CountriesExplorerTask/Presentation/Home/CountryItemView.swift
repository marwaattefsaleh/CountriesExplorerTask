//
//  CountryItemView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import Kingfisher
struct CountryItemView: View {
    @Binding var item: CountryEntity
    let onAction: (CountryItemViewAction) -> Void

    var body: some View {
        VStack(spacing: Theme.Sizes.pt6) {
            HStack {
                KFImage(URL(string: item.flag ?? ""))
                    .resizable()
                    .cacheOriginalImage()
                    .onFailure { e in
                        debugPrint("Image loading failed: \(e)")
                    }
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    }
                    .scaledToFill()
                    .frame(width: Theme.Sizes.pt60, height: Theme.Sizes.pt45)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.Sizes.pt8)) // 👈 this makes the image corners rounded
                    .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt8)
                    .padding(.trailing, Theme.Sizes.pt4)
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                    
                    Text(item.cca2)
                        .font(.system(size: Theme.Sizes.pt12, weight: .regular, design: .default))
                        .padding(Theme.Sizes.pt4)
                        .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt4)
                }
                Spacer()
                Button(action: {
                    onAction(.delete(item.cca2))
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                    
                }.frame(width: Theme.Sizes.pt35, height: Theme.Sizes.pt35)
            }
            
            HStack(spacing: Theme.Sizes.pt4) {
                Text("Capital:")
                    .font(.system(size: Theme.Sizes.pt14, weight: .medium, design: .default))
                
                Text(item.capitalName ?? "")
                    .font(.system(size: Theme.Sizes.pt14, weight: .regular, design: .default))
                
                Spacer()
            }
            
            HStack(spacing: Theme.Sizes.pt4) {
                Text("Currency:")
                    .font(.system(size: Theme.Sizes.pt14, weight: .medium, design: .default))
                
                Text(item.currency ?? "")
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
