//
//  TTDTattoosRepository.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Foundation

class FakeTattoosRepository: TattoosRepository {
    func getListOfTattos(page: Int, completion: @escaping (Result<TattooListPage, Error>) -> Void) {
        
    }
    
    func getInfoForTattoo(with id: Int, completion: @escaping (Result<TattooDetails, Error>) -> Void) {
        
    }

}
