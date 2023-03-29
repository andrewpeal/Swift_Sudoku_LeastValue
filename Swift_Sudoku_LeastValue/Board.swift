//
//  Board.swift
//  Sudoku_GUI
//
//  Created by Andrew Peal on 27/3/2023.
//
//  Sudoku Board class providing interfaces for all
//  aspects of generating a Sudoku Board.
//

import Foundation

class Board {
    var yAxis = ["a","b","c","d","e","f","g","h","i"]
    var xAxis = [1,2,3,4,5,6,7,8,9]
    var numbers = ([1,2,3,4,5,6,7,8,9])
    var board = [String: Cell]()
    let s = [1,4,7]
    var rowOrder : [String] = [String]()
    var boxOrder : [String] = [String]()
    var diagonalOrder : [String] = [String]()
    
    init(fillBoard shouldFill: Bool) {
        setRowOrder()
        setBoxOrder()
        setDiagonalOrder()
        createCellsAndRows()
        createColumns()
        createCubes()
        if shouldFill {
            fillCompleteBoard()
        }
    }
    
    /*
     Function to set the row order into a String Array
     Use this array to traverse the board in row order.
     */
    func setRowOrder() {
        
        for xVal in xAxis {
            for yVal in yAxis {
                rowOrder.append("\(yVal)\(xVal)")
            }
        }
    }
    
    /*
     Function to set the box order into a String Array
     Use this array to traverse the board in box order.
     */
    func setBoxOrder() {
        
        func a (n: Int, m: Int) {
            for y in m...(m + 2) {
                for x in n...(n + 2) {
                    boxOrder.append("\(yAxis[y - 1])\(xAxis[x - 1])")
                }
            }
        }

        for q in s {
            for p in s {
                a(n: p, m: q)
            }
        }
    }
    
    /*
     Function to set the diagonal order into a String Array
     Use this array to traverse the board in diagonal order.
     Diagonal order means the three cubes diagonal to each
     other. This is a common Sudoku technique.
     */
    func setDiagonalOrder() {
        let  a1 = "a1", a2 = "a2", a3 = "a3", a4 = "a4", a5 = "a5", a6 = "a6", a7 = "a7", a8 = "a8", a9 = "a9", b1 = "b1", b2 = "b2", b3 = "b3", b4 = "b4", b5 = "b5", b6 = "b6", b7 = "b7", b8 = "b8", b9 = "b9", c1 = "c1", c2 = "c2", c3 = "c3", c4 = "c4", c5 = "c5", c6 = "c6", c7 = "c7", c8 = "c8", c9 = "c9", d1 = "d1", d2 = "d2", d3 = "d3", d4 = "d4", d5 = "d5", d6 = "d6", d7 = "d7", d8 = "d8", d9 = "d9", e1 = "e1", e2 = "e2", e3 = "e3", e4 = "e4", e5 = "e5", e6 = "e6", e7 = "e7", e8 = "e8", e9 = "e9", f1 = "f1", f2 = "f2", f3 = "f3", f4 = "f4", f5 = "f5", f6 = "f6", f7 = "f7", f8 = "f8", f9 = "f9", g1 = "g1", g2 = "g2", g3 = "g3", g4 = "g4", g5 = "g5", g6 = "g6", g7 = "g7", g8 = "g8", g9 = "g9", h1 = "h1", h2 = "h2", h3 = "h3", h4 = "h4", h5 = "h5", h6 = "h6", h7 = "h7", h8 = "h8", h9 = "h9", i1 = "i1", i2 = "i2", i3 = "i3", i4 = "i4", i5 = "i5", i6 = "i6", i7 = "i7", i8 = "i8", i9 = "i9"
        diagonalOrder = [a1,a2,a3,b1,b2,b3,c1,c2,c3,d4,d5,d6,e4,e5,e6,f4,f5,f6,g7,g8,g9,h7,h8,h9,i7,i8,i9]

    }
    
    /*
     Function to create the cells and the rows of the board and
     add a reference to the row to each child cell.
     */
    func createCellsAndRows() {
        var row: Row
        for y in yAxis {
            row = Row(desc: "Row \(y)")
            for x in xAxis {
                board["\(y)\(x)"] = Cell(pos: "\(y)\(x)", row: row)
            }
        }
    }

    /*
     Function to create the columns of the board and
     add a reference to the column to each child cell.
     */
    func createColumns() {
        var col: Column
        for x in xAxis {
            col = Column(desc: "Column \(x)")
            for y in yAxis {
                board["\(y)\(x)"]?.column = col
            }
        }
    }
    
    /*
     Function to create the cubes of the board and
     add a reference to the cube to each child cell.
     */
    func createCubes() {
        var parent : Cube
        var cubeNum = 1
        var parentArray = [Cube]()
        for m in s {
            for n in s {
                parent = Cube(desc: "Cube \(cubeNum)")
                parentArray.append(parent)
                for y in m...(m + 2) {
                    for x in n...(n + 2) {
                        parent.children.append("\(yAxis[y - 1])\(xAxis[x - 1])")
                        board["\(yAxis[y - 1])\(xAxis[x - 1])"]?.parent = parent
                    }
                }
                cubeNum += 1
            }
        }
    }
    
    /*
     Function to generate a puzzle by filling the board.
     This is the most basic puzzle generation algorithm.
     Choose a random number, make sure it doesn't conflict
     with the row, column or cube.
     */
    func fillBoard(fillOrder: [String]) {
        
        for pos in fillOrder {
            insertValue(into: pos)
        }
    }
    
    /*
     Function to insert a value into a Cell
     */
    func insertValue(into pos: String) {
        var fillValue : Int
        let currCell = board[pos]!
        if (currCell.isEmpty) {
            let remainOptions = currCell.options
            if remainOptions.isEmpty {
                fillValue = 0
                return
            }
            else { fillValue = remainOptions.randomElement()! }
            board[pos]?.insert(value: fillValue)
        }
    }
    
    /*
     Function to clear a Cell by calling the clear() function of the Cell.
     */
    func clearCell(position pos : String) {
        let currCell = board[pos]!
        currCell.clear()
    }
    
    /*
     Function to clear the entire Cube, resetting all
     Cells to 0.
     Only really used in development for testing purposes.
     */
    func clearCube(position pos : String) {
        let currCell = board[pos]!
        let parent = currCell.parent
        let children = parent!.children
        
        for child in children {
            clearCell(position: child)
        }
    }
    
    /*
     Function to clear the entire puzzle(board) of all values
     and reset all variables.
     */
    func clearBoard() {
        for pos in rowOrder {
            board[pos]!.clear()
        }
    }
    
    /*
     Function to fill the entire Cube.
     Only really used in development for testing purposes.
     */
    func fillCube(position pos : String) {
        let currCell = board[pos]!
        let parent = currCell.parent
        let children = parent!.children
        fillBoard(fillOrder: children)

    }
            
    /*
     Function to find the Cell with the lowest number
     of remaining options. This will form part of the
     lowest-option algorithm.
     */
    func findLowest() -> String {
        var result = "a1" // initialise to first item
        var count = 9 // initialise to maximum possible
        
        for pos in rowOrder {
            let currCell = board[pos]!
            
            if (currCell.isEmpty) {
                let options = currCell.options

                if (options.count < count) {
                    count = options.count
                    result = pos
                }
            }
        }
        return result
    }
    
    /*
     Function to check if the board is complete.
     Returns false if any of the cells are empty, true otherwise.
     */
    func checkBoard() -> Bool{
        var check = true
        for pos in rowOrder {
            if board[pos]!.isEmpty {
                check = false
            }
        }
        return check
    }
    
    /*
     Function to generate a Sudoku puzzle using the lowest-option
     algorithm, findLowest. The count variable is a control to prevent
     an infinite loop. When a puzzle contains an invalid condition, checkBoard
     will never return true.
     */
    func fillBoardLowest() {
        var count = 0
        while !checkBoard() && count < 81 {
            insertValue(into: findLowest())
            count += 1
        }
    }
    
    /*
     Function to generate a complete Sudoku puzzle.
     This is a brute-force algorithm and not efficient.
     An attempt is made to generate the puzzle. If the puzzle contains an
     invalid condition, checkBoard returns false and the process must be repeated.
     */
    func fillCompleteBoard() {
        while !checkBoard() {
            clearBoard()
            fillBoardLowest()
        }
    }
    
    /*
     Function to print the board to the console.
     Only really used for debugging purposes.
     */
    func printBoard () {
        
        var line : String = " ";
        for _ in 1...29 {
            line += "-";
        }
        
        print(line);
        
        for xVal in yAxis {
            
            var tString = "|";
            var cellPosition : String;
            var currCell : Cell;
            let thirds = [3,6,9];
            let div = ["c", "f", "i"];
            
            for yVal in xAxis {
                
                cellPosition = xVal + String(yVal);
                currCell = board[cellPosition]!
                if (thirds.contains(yVal)){
                    tString += " " + String(currCell.value) + " |";
                }
                else { tString += " " + String(currCell.value) + " "; }
            }
            print(tString);

            if(div.contains(xVal)) {
                print(line);
            }
        }
    }
}
