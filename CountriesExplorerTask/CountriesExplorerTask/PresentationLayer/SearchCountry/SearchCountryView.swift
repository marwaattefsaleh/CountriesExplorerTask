//
//  SearchCountryView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import SwiftUI_Shimmer
import AlertToast

struct SearchCountryView: View {
    @StateObject var viewModel: SearchCountryViewModel
    @State var searchText: String = ""
    @State private var isEditing = false
    @Environment(\.dismiss) private var dismiss
    let onCountrySaved: () -> Void

    var body: some View {
        VStack {
            viewSearch
            
            ScrollView {
                if viewModel.isLoading {
                    viewLoadingState
                } else if viewModel.countryEntityList.isEmpty {
                    viewEmptyState
                } else {
                    viewListItems
                }
            }
        }
        .padding(Theme.Sizes.pt16)
        .hexBackground(Theme.Colors.colorF9fafb)
        .navigationTitle(Text("Add Country"))
        .toast(isPresenting: $viewModel.showToast, duration: 2) {
            AlertToast(type: .regular, title: viewModel.toastMessage)
        }.onReceive(viewModel.$itemSelected) { itemSelected in
            if itemSelected {
                onCountrySaved()
                dismiss()
            }
        }
    }
    
    var viewSearch: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("search", text: $searchText, prompt: Text("Search for country...")
                    .foregroundColor(Color(hex: Theme.Colors.color8E8E93)))
                .accessibilityIdentifier("searchTextField")
                .hexForeground(Theme.Colors.color000000)
                .submitLabel(.search) // Show search button on keyboard
                .onSubmit {
                    viewModel.searchCountries(query: searchText)
                    UIApplication.shared.dismissKeyboard()
                }
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                        
                    } .frame(width: Theme.Sizes.pt20, height: Theme.Sizes.pt20).padding(0)
                        .accessibilityIdentifier("clearSearchButton")
                    
                }
                
            }.padding(Theme.Sizes.pt8).hexBackground(Theme.Colors.color8E8E93, opacity: 0.12, cornerRadius: Theme.Sizes.pt10)
            
            if isEditing {
                Button("Cancel") {
                    withAnimation {
                        searchText = ""
                        isEditing = false
                        UIApplication.shared.dismissKeyboard()
                    }
                }.foregroundColor(Color(hex: Theme.Colors.color000000))
            }
        }.onChange(of: searchText) { _, newValue in
            withAnimation {
                if !newValue.isEmpty {
                    isEditing = true
                }
            }
        }
    }
    var viewListItems: some View {
        LazyVStack {
            ForEach(0..<($viewModel.countryEntityList.wrappedValue.count), id: \.self) { ind in
                SearchItemView(item: $viewModel.countryEntityList[ind])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.saveSelectedCountry(viewModel.countryEntityList[ind])
                    }
            }
        }
    }
    var viewEmptyState: some View {
        VStack(spacing: Theme.Sizes.pt8) {
            Image(systemName: "folder.badge.plus")
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            
            Text("No results found")
                .font(.system(size: Theme.Sizes.pt16, weight: .bold, design: .default))
                .foregroundColor(Color(hex: Theme.Colors.color8E8E93))
            
            Text("Try searching for another country")
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
    
    var viewLoadingState: some View {
        VStack {
            SearchItemShimmerView()
            SearchItemShimmerView()
        }
    }
}
