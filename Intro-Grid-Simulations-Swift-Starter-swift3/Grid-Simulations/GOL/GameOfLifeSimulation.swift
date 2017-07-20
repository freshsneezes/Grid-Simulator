//
//  GameOfLifeSimulation.swift
//  Grid-Simulations
//
//  Created by Yujin Ariza on 3/21/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public class GameOfLifeSimulation: Simulation {

    public var liveChar: Character = "👾"
    
    public override func update() {
        //Creating the variable newgrid
        var newgrid = grid
        
        //Changing the columns
        //BUG is that the new grid is being refreshed too often
        //that took me 5 hours to find wow
        for x in 0..<grid.count {
            //Changing the rows
            for y in 0..<grid[0].count{
                //Counting neighbours
                let neighbors = countNeighbors(grid: grid, column: x, row: y)
                //if less than 2 neighbours it dies
                if neighbors < 2 {
                    newgrid[x][y] = nil
                }
                //if 2 neighbours it lives
                if neighbors == 2 && newgrid[x][y] == liveChar {
                    newgrid[x][y] = liveChar
                }
                //if 3 neighbours it lives/revives
                if neighbors == 3 {
                    newgrid[x][y] = liveChar
                }
                //if more than 3 neighbours it dies
                if neighbors > 3 {
                    newgrid[x][y] = nil
                }
            }
        }
        grid = newgrid
    }

    func getAlive(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        if x < grid.count && x >= 0 && y < grid[0].count && y >= 0 {
            if grid[x][y] != nil {
                return 1
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func countNeighbors(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        var counter = 0
        //4
        var alive = getAlive(grid: grid, column: x - 1, row: y)
        counter += alive
        //1
        alive = getAlive(grid: grid, column: x - 1, row: y + 1)
        counter += alive
        //2
        alive = getAlive(grid: grid, column: x, row: y + 1)
        counter += alive
        //3
        alive = getAlive(grid: grid, column: x + 1, row: y + 1)
        counter += alive
        //6
        alive = getAlive(grid: grid, column: x + 1, row: y)
        counter += alive
        //9
        alive = getAlive(grid: grid, column: x + 1, row: y - 1)
        counter += alive
        //8
        alive = getAlive(grid: grid, column: x, row: y - 1)
        counter += alive
        //7
        alive = getAlive(grid: grid, column: x - 1, row: y - 1)
        counter += alive
        print(counter)
        return counter
    }
}
