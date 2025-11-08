//
//  CountryDetailsView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import Kingfisher
import AlertToast

struct CountryDetailsView: View {
    @StateObject var viewModel: CountryDetailsViewModel
    let country: CountryEntity

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }.accessibilityIdentifier("dismissButton")
                .frame(width: Theme.Sizes.pt30, height: Theme.Sizes.pt30)
                    .foregroundColor(Color(hex: Theme.Colors.color000000))
                Spacer()
                Text(country.name)
                    .accessibilityIdentifier("countryNameLabel")
                    .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                Text(country.cca2)
                    .font(.system(size: Theme.Sizes.pt12, weight: .regular, design: .default))
                    .padding(Theme.Sizes.pt4)
                    .hexBackground(Theme.Colors.colorEceef2, cornerRadius: Theme.Sizes.pt4)
                Spacer()
                Color.clear.frame(width: Theme.Sizes.pt30, height: Theme.Sizes.pt30)
            }
            
            Text(country.region ?? "N/A")
                .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
                .padding(.bottom, Theme.Sizes.pt16)
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            ScrollView {
                KFImage(URL(string: country.flag ?? ""))
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
                    .frame(maxWidth: .infinity)
                    .frame(height: Theme.Sizes.pt152)
                    .clipShape(RoundedRectangle(cornerRadius: Theme.Sizes.pt8)) // 👈 this makes the image corners rounded
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
            
            Text(country.capitalName ?? "N/A")
                .accessibilityIdentifier("capitalLabel")
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
            
            Text(country.currency ?? "N/A")
                .accessibilityIdentifier("currencyLabel")
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
                    Text("\((country.population ?? 0) == 0 ? "N/A" :  "\(country.population!)")")
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
                    Text(country.region ?? "N/A")
                        .accessibilityIdentifier("regionLabel")
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
                Text(country.languages ?? "N/A")
                    .accessibilityIdentifier("languagesLabel")
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
                Text(country.coordinates ?? "N/A")
                    .accessibilityIdentifier("coordinatesLabel")
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
