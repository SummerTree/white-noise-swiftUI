//
//  MainScreenView.swift
//  WhiteNoise-SwiftUI
//
//  Created by Александра Башкирова on 05.07.2020.
//  Copyright © 2020 Alexandra Bashkirova. All rights reserved.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainScreenViewModel

    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        #if os(iOS)
        UITableView.appearance().separatorStyle = .none
        #endif
    }

    var body: some View {
        let factory = viewModel.mainScreenViewsFactory
        return HStack {
            VStack(alignment: .leading, spacing: 24.0) {
                factory.createNameAppView()
                HStack {
                    factory.createCardView()
                        .layoutPriority(1)
                    factory.createTrackTableView()
                        .padding(.top, 35.0)
                        .background(Color.clear)
                }
                #if os(iOS)
                factory.createTrackTableView()
                    .padding(.leading, -16.0)
                #endif
                factory.createPlayer()
            }
            .padding(8.0)
//            #if os(macOS)
//            VStack(alignment: .leading) {
//
//                HStack {
//                    Text("Minutes")
//                    Picker("", selection: $minutes){
//                        let times = [30, 60, 90]
//                        ForEach(times, id: \.self) { i in
//                            Text("\(i) min").tag(i)
//                        }
//                    }.pickerStyle(PopUpButtonPickerStyle())
//                }
//                .padding(.bottom, 40)
//                Spacer()
//            }
//            #endif
            factory.createSplitView()
            factory.createMenuView()
        }
        .padding(.leading, 32.0)
    }

    private func trackTapped(title: String) {
        print("Track \(title) tapped")
    }
}

#if DEBUG
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainScreenView(
                viewModel: MainScreenViewModel(
                    categoryRepository: CategoryRepositoryImpl(),
                    player: NoisePlayer(),
                    categoryMenuItemViewModelFactory: CategoryMenuFactory(),
                    musicTrackViewModelFactory: MusicTracksFactory()
                )
            )
            MainScreenView(
                viewModel: MainScreenViewModel(
                    categoryRepository: CategoryRepositoryEmptyImpl(),
                    player: NoisePlayer(),
                    categoryMenuItemViewModelFactory: CategoryMenuFactory(),
                    musicTrackViewModelFactory: MusicTracksFactory()
                )
            )
        }
    }
}
#endif
