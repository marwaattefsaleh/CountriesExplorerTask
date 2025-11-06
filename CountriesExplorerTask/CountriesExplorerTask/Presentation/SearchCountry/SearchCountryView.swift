//
//  SearchCountryView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI
import SwiftUI_Shimmer

struct SearchCountryView: View {
    @State var searchText: String = ""
    @State private var isEditing = false

    @Binding var path: NavigationPath

    var body: some View {
        VStack {
           viewSearch
            ScrollView {
                LazyVStack {
                    ForEach(0..<5) { _ in
                        SearchItemView()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            path.removeLast()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, Theme.Sizes.pt16)
        .hexBackground(Theme.Colors.colorF9fafb)
        .navigationTitle(Text("Add Country"))
    }
    
    var viewSearch: some View {
        HStack {
            HStack {
                Image("search")
                TextField("search", text: $searchText, prompt: Text("Search for country...")
                    .foregroundColor(Color(hex: Theme.Colors.color8E8E93)))
                .accessibilityIdentifier("searchTextField")
                .hexForeground(Theme.Colors.color000000)
                .submitLabel(.search) // Show search button on keyboard
                .onSubmit {
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
