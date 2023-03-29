//
//  main.swift
//  Swift_Sudoku_LeastValue
//
//  Created by Andrew Peal on 29/3/2023.
//
//  Sudoku abstraction for generating a Sudoku puzzle
//  The generated puzzle is stored in a key value Array
//  The key is the grid position, the value is a Cell object

import Foundation

// create an instance of Board and generate a puzzle.
var sudoku = Board(fillBoard: true)

// print the puzzle to the console.
sudoku.printBoard()

