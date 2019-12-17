//
//  TattoListControllerViewModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

protocol TattoListControllerViewModeling: class {
    var numberOfRows: Int { get }
    func userDidSelect(row: Int)
    func displayModelForCell(at row: Int) -> TattooListCellDisplayModel
}

class TattoListControllerViewModel: TattoListControllerViewModeling {
//    private var tattoos: []
    // MARK: - Properties
    var numberOfRows: Int { 0 }
    
    // MARK: - Methods
    init() {
    
    }
    
    func userDidSelect(row: Int) {
        //Handle tap
    }
    
    func displayModelForCell(at row: Int) -> TattooListCellDisplayModel {
        TattooListCellDisplayModel()
    }
    
}
