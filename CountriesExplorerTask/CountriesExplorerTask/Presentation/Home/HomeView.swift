//
//  HomeView.swift
//  CountriesExplorerTask
//
//  Created by Marwa Attef on 06/11/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var path = NavigationPath()
    @State private var showDetailsSheet: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Text("Your selected countries 0/5")
                    Spacer()
                    Button(action: {
                        path.append("Search")
                    }) {
                        Image(systemName: "plus")
                        Text("Add Country")
                    }.foregroundColor(Color(hex: Theme.Colors.colorFFFFFF))
                        .padding(Theme.Sizes.pt4).hexBackground(Theme.Colors.color000000, cornerRadius: Theme.Sizes.pt8)
                }
                ScrollView {
                    LazyVStack {
                        ForEach(0..<5) { _ in
                            CountryItemView(onAction: { _ in
                                
                            })
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showDetailsSheet = true
                            }
                        }
                    }
                }
            }
            .padding(Theme.Sizes.pt16)
            .hexBackground(Theme.Colors.colorF9fafb)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Countries Explorer"))
            .navigationDestination(for: String.self) { value in
                if value == "Search" {
                    SearchCountryView(path: $path)
                }
            }
            .sheet(isPresented: $showDetailsSheet) {
                CountryDetailsView()
            }
        }.tint(Color(hex: Theme.Colors.color000000))
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

#Preview {
    HomeView()
}
