//
//  Container.swift
//  Sudoku_GUI
//
//  Created by Andrew Peal on 27/3/2023.
//
//  Parent class for Rows, Columns and Cubes
//  

import Foundation

class Container : Identifiable, Hashable, Equatable {
    
    let id = UUID()
    var desc = ""
    var values = Set<Int>()
    var options : Set<Int> = ([1,2,3,4,5,6,7,8,9])
    
    init () {
         
    }
    
    init (desc: String) {
        self.desc = desc
    }
        
    func insert (value insValue: Int) {
        values.insert(insValue)
        options.remove(insValue)
    }
    
    func remove (value delValue: Int) {
        values.remove(delValue)
        options.insert(delValue)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Container, rhs: Container) -> Bool {
        return lhs.id == rhs.id
    }
}

class Row : Container {

}

class Column : Container {
    
}

class Cube : Container {
    var children = [String]()
    
}
