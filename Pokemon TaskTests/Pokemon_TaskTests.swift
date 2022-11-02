//
//  Pokemon_TaskTests.swift
//  Pokemon TaskTests
//
//  Created by MacMini on 26.10.22.
//

import XCTest
@testable import Pokemon_Task

class Pokemon_TaskTests: XCTestCase {
    
    var manager: NetworkManager!
    var pokemonData: PokemonData!
    var viewModel: MainViewModel!
    let apiUrl = "https://pokeapi.co/api/v2/pokemon"

    override func setUpWithError() throws {
        try super.setUpWithError()
        manager = NetworkManager()
        viewModel = MainViewModel(viewController: nil)
        var pokemonData: PokemonData
        manager.fetchRequest(stringUrl: apiUrl) { pokemonData in
            self.pokemonData = pokemonData
        }
    }

    override func tearDownWithError() throws {
        manager = nil
        pokemonData = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testPerformanceExample() throws {
        self.measure(metrics: [XCTCPUMetric.init(), XCTClockMetric.init(), XCTStorageMetric.init(), XCTMemoryMetric.init()], block: {
            viewModel = MainViewModel(viewController: nil)
            let _ = viewModel.getCount()
        })
    }

}
