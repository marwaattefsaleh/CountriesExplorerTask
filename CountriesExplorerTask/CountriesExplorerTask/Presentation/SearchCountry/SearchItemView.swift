//
//  SearchItemView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//
import SwiftUI

struct SearchItemView: View {

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
                    
                    Text("City Name")
                        .font(.system(size: Theme.Sizes.pt14, weight: .regular, design: .default))
                    Text("Currency Name")
                        .font(.system(size: Theme.Sizes.pt14, weight: .regular, design: .default))
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color(hex: Theme.Colors.color000000))
                    
                }.frame(width: Theme.Sizes.pt16, height: Theme.Sizes.pt16)
            }
         
        }.padding(Theme.Sizes.pt8)
            .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                    .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
            )
    }
}
