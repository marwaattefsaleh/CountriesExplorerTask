//
//  HomeView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    @State private var path = NavigationPath()
    @State private var selectedCountry: CountryEntity?
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Text(viewModel.txtNumberSavedCountries)
                    Spacer()
                    if viewModel.showAddButton {
                        Button(action: {
                            path.append("Search")
                        }) {
                            Image(systemName: "plus")
                            Text("Add Country")
                        }.foregroundColor(Color(hex: Theme.Colors.colorFFFFFF))
                            .padding(Theme.Sizes.pt4).hexBackground(Theme.Colors.color000000, cornerRadius: Theme.Sizes.pt8)
                    }
                }
                ScrollView {
                    if viewModel.countryEntityList.isEmpty {
                        viewEmptyState
                    } else {
                        viewListItems
                    }
                }
            }
            .padding(Theme.Sizes.pt16)
            .hexBackground(Theme.Colors.colorF9fafb)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Countries Explorer"))
            .navigationDestination(for: String.self) { value in
                if value == "Search" {
                    viewModel.navigateToSearch()
                }
            }
            .sheet(item: $selectedCountry) { country in
                viewModel.navigateToDetails(country: country)
            }
        }.tint(Color(hex: Theme.Colors.color000000))
            .onAppear {
                viewModel.getCountries()
            }.toast(isPresenting: $viewModel.showToast, duration: 2) {
                AlertToast(type: .regular, title: viewModel.toastMessage)
            }
    }
    var viewListItems: some View {
        LazyVStack {
            ForEach(0..<($viewModel.countryEntityList.wrappedValue.count), id: \.self) { ind in
                CountryItemView(item: $viewModel.countryEntityList[ind], onAction: { action in
                    switch action {
                    case .delete:
                        viewModel.deleteCountry(by: viewModel.countryEntityList[ind].cca2)
                        
                    }
                }, showDeleteButton: viewModel.countryEntityList.count > 1)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCountry = viewModel.countryEntityList[ind]
                    
                }
            }
        }
    }
    var viewEmptyState: some View {
        VStack(spacing: Theme.Sizes.pt8) {
            Image(systemName: "folder.badge.plus")
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            
            Text("No countries selected yet")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            
            Text("Add countries to start exploring")
                .font(.system(size: Theme.Sizes.pt16, weight: .regular, design: .default))
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.Sizes.pt30)
        .hexBackground(Theme.Colors.colorFFFFFF, cornerRadius: Theme.Sizes.pt8)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Sizes.pt8)
                .stroke(Color(hex: Theme.Colors.colorDDDDDD), lineWidth: Theme.Sizes.pt1)
        ).padding(.top, Theme.Sizes.pt16)
    }
}
