//
//  RecordViewModel.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 19/07/22.
//

import Foundation

class RecordViewModel: RecordViewModelProtocol {
    weak var view: RecordViewProtocol?
    var router: RecordRouterProtocol?
    var selectRecord: ((String) -> Void)?
    private var listRecord: [String]?
    
    func getlistRecord() {
        listRecord = HelperRecord.recordList
    }
    
    func listRecordCount() -> Int? {
        return listRecord?.count
    }
    
    func recordText(index: Int) -> String? {
        return listRecord?[index]
    }
    
    func searchRecordText(index: Int) {
        selectRecord?(listRecord?[index] ?? "")
        router?.close()
    }
}
