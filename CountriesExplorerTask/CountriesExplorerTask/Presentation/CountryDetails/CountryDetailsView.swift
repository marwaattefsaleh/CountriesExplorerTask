//
//  CountryDetailsView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI

struct CountryDetailsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }.frame(width: Theme.Sizes.pt30, height: Theme.Sizes.pt30)
                    .foregroundColor(Color(hex: Theme.Colors.color000000))
                Spacer()
                Text("Country Name")
                    .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                Text("cca2")
                    .font(.system(size: Theme.Sizes.pt12, weight: .regular, design: .default))
                    .padding(Theme.Sizes.pt4)
                    .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt4)
                Spacer()
                Color.clear.frame(width: Theme.Sizes.pt30, height: Theme.Sizes.pt30)
            }
            
            Text("Region")
                .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
                .padding(.bottom, Theme.Sizes.pt16)
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            ScrollView {
                Image(systemName: "flag")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt8)
                    .padding(.trailing, Theme.Sizes.pt4)
                
                Divider().padding(.vertical, Theme.Sizes.pt16)
                viewCapital
                viewCurrency
                Divider().padding(.vertical, Theme.Sizes.pt16)
                viewStatistics
                Divider().padding(.vertical, Theme.Sizes.pt16)
                viewAdditionalDetails
            }
        }.padding(Theme.Sizes.pt16)
            .hexBackground(Theme.Colors.colorF9fafb)
        
    }
    
    var viewCapital: some View {
        VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
            Text("Capital")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Capital name")
                .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
        } .padding(Theme.Sizes.pt8)
            .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                    .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
            )
    }
    
    var viewCurrency: some View {
        VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
            Text("Currency")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Currency name")
                .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
        } .padding(Theme.Sizes.pt8)
            .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                    .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
            )
    }
    
    var viewStatistics: some View {
        VStack(alignment: .leading) {
            Text("Statistics")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))

            HStack {
                VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
                    HStack {
                        Image(systemName: "person")
                        Text("Population")
                            .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text("Population number")
                        .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
                } .padding(Theme.Sizes.pt8)
                    .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                            .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
                    )
                Spacer()
                VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Region")
                            .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text("Region name")
                        .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
                } .padding(Theme.Sizes.pt8)
                    .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                            .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
                    )
            }
        }
    }
    
    var viewAdditionalDetails: some View {
        VStack(alignment: .leading) {
            Text("Additional Details")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
            VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
                HStack {
                    Image(systemName: "character.phonetic")
                    
                    Text("Languages")
                        .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Languages names")
                    .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
            } .padding(Theme.Sizes.pt8)
                .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                        .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
                )
            
            VStack(alignment: .leading, spacing: Theme.Sizes.pt8) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Coordinates")
                        .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("Coordinates detials")
                    .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
            } .padding(Theme.Sizes.pt8)
                .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                        .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
                )
        }
    }
}

#Preview {
    CountryDetailsView()
}
