//
//  HomeViewModel.swift
//  MainApplication
//
//  Created by alpiopio on 02/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//

import Foundation

struct Cell {
    enum CellType {
        case checkbox
        case radiobutton
    }
    
    let name: String
    let type: CellType
    var list: [List]
}

struct List {
    let name: String
    var isSelected: Bool
}

protocol IHomeViewModel {
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String?
    func itemOfRowsInIndexPath(indexPath: IndexPath) -> List?
    func didSelectRowAt(indexPath: IndexPath) -> [IndexPath]
}

class HomeViewModel: IHomeViewModel {
    private var items: [Cell] = [
        Cell(name: "Pertanyaan 1 checkbox", type: .checkbox, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ]),
        Cell(name: "Pertanyaan 2 radiobutton", type: .radiobutton, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ]),
        Cell(name: "Pertanyaan 3 checkbox", type: .checkbox, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ]),
        Cell(name: "Pertanyaan 4 radiobutton", type: .radiobutton, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ]),
        Cell(name: "Pertanyaan 5 checkbox", type: .checkbox, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ]),
        Cell(name: "Pertanyaan 6 radiobutton", type: .radiobutton, list: [
            List(name: "Jawaban 1", isSelected: false),
            List(name: "Jawaban 2", isSelected: false),
            List(name: "Jawaban 3", isSelected: false),
            List(name: "Jawaban 4", isSelected: false)
        ])
    ]
    
    func numberOfSections() -> Int {
        return items.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return items[section].list.count
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return items[section].name
    }
    
    func itemOfRowsInIndexPath(indexPath: IndexPath) -> List? {
        return items[indexPath.section].list[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> [IndexPath] {
        switch items[indexPath.section].type {
        case .checkbox:
            items[indexPath.section].list[indexPath.row].isSelected.toggle()
            return [indexPath]
        default:
            var indicies: [IndexPath] = []
            for i in 0..<items[indexPath.section].list.count {
                items[indexPath.section].list[i].isSelected = false
                indicies.append(IndexPath(row: i, section: indexPath.section))
            }
            items[indexPath.section].list[indexPath.row].isSelected.toggle()
            return indicies
        }
    }
}
