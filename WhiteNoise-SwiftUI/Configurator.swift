//
//  Configurator.swift
//  WhiteNoise-SwiftUI
//
//  Created by Александра Башкирова on 05.07.2020.
//  Copyright © 2020 Alexandra Bashkirova. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit
#else
import AppKit
#endif

class Configurator {
    private let categoryRepository: CategoryRepository
    private let player: NoisePlayer
    init() {
        categoryRepository = CategoryRepositoryImpl()
        player = NoisePlayer()
    }

    #if os(iOS)
    func configure() -> UIViewController {
        let mainScreenViewModel = MainScreenViewModel(
            categoryRepository: categoryRepository,
            player: player,
            categoryMenuItemViewModelFactory: CategoryMenuFactory(),
            musicTrackViewModelFactory: MusicTracksFactory()
        )
        let contentView = MainScreenView(viewModel: mainScreenViewModel)
        return UIHostingController(rootView: contentView)
    }
    #else
    func configure() -> NSViewController {
        let mainScreenViewModel = MainScreenViewModel(
            categoryRepository: categoryRepository,
            player: player,
            categoryMenuItemViewModelFactory: CategoryMenuFactory(),
            musicTrackViewModelFactory: MusicTracksFactory()
        )
        let contentView = MainScreenView(viewModel: mainScreenViewModel)
        return NSHostingController(rootView: contentView)
    }
    #endif
}
