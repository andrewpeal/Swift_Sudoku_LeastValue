//
//  Cell.swift
//  Sudoku_GUI
//
//  Created by Andrew Peal on 27/3/2023.
//
//  Abstraction class for a single cell in a Sudoku puzzle
//


import Foundation

class Cell : Identifiable, Hashable, Equatable, CustomStringConvertible {
    
    let id : UUID               // UUID of the Cell
    var pos : String            // position of the Cell in the board
    var value : Int             // the value [1...9] of the Cell
    var isEmpty = true          // Boolean switch
    var row : Row?              // reference to the parent row the Cell belongs to
    var column : Column?        // reference to the parent column the Cell belongs to
    var parent : Cube?          // feference to the parent cube the Cell belongs to
    var options : Set<Int> { getOptions() } // compute the available options
    var accepted = [1,2,3,4,5,6,7,8,9]
    
    /* The description property requires the class to conform
     to the CustomStringConvertible protocol.
     Use this to return a String representation of the Cell
    */
    var description : String {
        return id.description
    }
    
    init (pos: String) {
        self.pos = pos
        value = 0
        id = UUID()
    }
    
    init (pos: String, row: Row) {
        self.pos = pos
        self.row = row
        value = 0
        id = UUID()
    }
    
    /*
     Function to return the Set of options available for the Cell
     This function is called by the options computed property.
     */
    func getOptions() -> Set<Int> {
        var remain = row!.options
        remain = remain.intersection(column!.options)
        remain = remain.intersection(parent!.options)
        return remain
    }
    
    /*
     Function to insert a value into the cell and
     update all variables.
     */
    func insert(value insValue: Int) {
        if (!accepted.contains(insValue)) {
            return
        }
        value = insValue
        row?.insert(value: insValue)
        column?.insert(value: insValue)
        parent?.insert(value: insValue)
        isEmpty = false
    }
    
    /*
     Function to clear the value in the cell and
     update all variables.
     */
    func clear() {
        if (value == 0) {
            return
        }
        row?.remove(value: value)
        column?.remove(value: value)
        parent?.remove(value: value)
        value = 0
        isEmpty = true
    }
    
    /*
     Required for protocol conformity
     */
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    /*
     Required for protocol conformity
     */
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getID() -> String {
        return id.uuidString
    }
    
    func getOptions() -> String {
        return options.description
    }
    
}
