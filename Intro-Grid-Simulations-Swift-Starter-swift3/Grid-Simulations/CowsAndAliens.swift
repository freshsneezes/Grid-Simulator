//
//  CowsAndAliens.swift
//  Grid-Simulations
//
//  Created by its on 14/7/2017.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

public class CowsAndAliens: Simulation {
    public var cow: Character = "🐮"
    public var alien: Character = "👽"
    
    var newgrid : [[Character?]] = []
    
    
    
    
    
    public override func setup() {
        grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
        
        //Setting up characters
        for x in 0..<grid.count {
            for y in 0..<grid[0].count{
                
                //50% chance of cows
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.34 {
                        grid[x][y] = cow
                    } else {
                        if randomZeroToOne() <= 0.5 {
                            grid[x][y] = alien
                        } else {
                            grid[x][y] = nil
                        }
                    }
                }
                
            }
        }
        newgrid = grid
    }
    
    
    
    
    
    public override func update() {
        newgrid = grid
        
        //Going through each cell
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                //1% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.1 {
                        newgrid[x][y] = cow
                    } else {
                        if randomZeroToOne() <= 0.05 {
                            newgrid[x][y] = alien
                        } else {
                            newgrid[x][y] = nil
                        }
                    }
                }
            }
        }
        
        //Abduction
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Cows get abducted by aliens
                if grid[x][y] == cow {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if cow or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if cowalien(x: xaxis, y: yaxis) == 2 {
                            newgrid[x][y] = nil
                        }
                    }
                }
                
                if grid[x][y] == alien {
                    newgrid[x][y] = nil
                }
                
            }
        }
        
        //Actually updating the grid
        grid = newgrid

    }
    
    
    
    
    
    //Checks if character within grid
    func isLegalPosition(x: Int, y: Int) -> Bool {
        if x < grid.count && x >= 0 && y < grid[0].count && y >= 0 {
            if grid[x][y] != nil {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    
    
    
    
    //Checks what cell is
    func cowalien(x: Int, y: Int) -> Int {
        var alive = isLegalPosition(x: x, y: y)
        
        if alive == true {
            if grid[x][y] == cow {
                return 1
            } else {
                if grid[x][y] == alien {
                    return 2
                } else {
                    return 3
                }
            }
        }
        return 3
    }
    
    
    
    
    
    //Getting neighbour positions
    func getNeighborPositions(x originX: Int, y originY: Int) -> [(x: Int, y: Int)] {
        var coordinates = [(originX, originY)]
        
        //4
        var alive = isLegalPosition(x: originX - 1, y: originY)
        if alive == true {
            coordinates.append((originX - 1, originY))
        }
        
        //1
        alive = isLegalPosition(x: originX - 1, y: originY + 1)
        if alive == true {
            coordinates.append((originX - 1, originY + 1))
        }
        
        //2
        alive = isLegalPosition(x: originX, y: originY + 1)
        if alive == true {
            coordinates.append((originX, originY + 1))
        }
        
        //3
        alive = isLegalPosition(x: originX + 1, y: originY + 1)
        if alive == true {
            coordinates.append((originX + 1, originY + 1))
        }
        
        //6
        alive = isLegalPosition(x: originX + 1, y: originY)
        if alive == true {
            coordinates.append((originX + 1, originY))
        }
        
        //9
        alive = isLegalPosition(x: originX + 1, y: originY - 1)
        if alive == true {
            coordinates.append((originX + 1, originY - 1))
        }
        
        //8
        alive = isLegalPosition(x: originX, y: originY - 1)
        if alive == true {
            coordinates.append((originX, originY - 1))
        }
        
        //7
        alive = isLegalPosition(x: originX - 1, y: originY - 1)
        if alive == true {
            coordinates.append((originX - 1, originY - 1))
        }
        //print (coordinates)
        return coordinates
    }

    
}
