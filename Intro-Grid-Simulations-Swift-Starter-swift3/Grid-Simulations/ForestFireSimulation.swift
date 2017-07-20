//
//  ForestFireSimulation.swift
//  Grid-Simulations
//
//  Created by its on 13/7/2017.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

public class ForestFireSimulation: Simulation {
    
    public var tree: Character = "🌲"
    public var fire: Character = "🔥"
    public var wall: Character = "✄"
    public var strong: Character = "🌳"
    public var jerk: Character = "🌱"
    
    var newgrid : [[Character?]] = []

    public override func setup() {
        jerkTreeSetup()
    }
    
    func aTinyForestSetup() {
        grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
        
        //Setting up trees
        for x in 0..<grid.count {
            for y in 0..<grid[0].count{
                
                //50% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.5 {
                        grid[x][y] = tree
                    } else {
                        grid[x][y] = nil
                    }
                }
                
            }
        }
        newgrid = grid
    }
    
    func jerkTreeSetup() {
        grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
        
        //Setting up trees
        for x in 0..<grid.count {
            for y in 0..<grid[0].count{
                
                //50% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.33 {
                        //grid[x][y] = tree
                        grid[x][y] = strong
                    } else {
                        if randomZeroToOne() <= 0.5 {
                            grid[x][y] = jerk
                        } else {
                            grid[x][y] = nil
                        }
                    }
                }
                
            }
        }
        newgrid = grid
    }
    
    //Generates trees
    public override func update() {
        jerkTrees()
    }
    
    //Checks if tree within grid
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
    func treefire(x: Int, y: Int) -> Int {
        var alive = isLegalPosition(x: x, y: y)
        
        if alive == true {
            //Returns 2 if tree, 1 if fire, 3 if wall, 4 if strong, 5 if jerk, nil if 6
            
            if grid[x][y] == tree{
                return 2
                //Returns 1 if fire
                
            } else {
                if grid[x][y] == fire {
                    return 1
                    
                } else {
                    if grid [x][y] == wall {
                        return 3
                        
                    } else {
                        if grid[x][y] == strong {
                            return 4
                        } else {
                            if grid[x][y] == jerk {
                                return 5
                            } else {
                                return 6
                            }
                        }
                    }
                
                }
            
            }
        
        }
        
        return 6
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
    
    func thunderboltAndLightning() {
        newgrid = grid
        
        //Going through each cell
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //1% chance of tree generation
                if randomZeroToOne() <= 0.01 {
                    newgrid[x][y] = tree
                } else {
                    if randomZeroToOne() <= 0.01 {
                        newgrid[x][y] = fire
                    } else {
                        newgrid[x][y] = nil
                    }
                }
                
                
            }
        }
        
        //Spreading fire
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into fire if they're next to fire
                if grid[x][y] == tree {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 1 {
                            newgrid[x][y] = fire
                        }
                    }
                }
                
                if grid[x][y] == fire {
                    newgrid[x][y] = nil
                }
                
            }
        }
        
        //Actually updating the grid
        grid = newgrid

    }
    
    
    
    
    
    func aTinyForest() {
        newgrid = grid
        
        //Going through each cell
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //1% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.05 {
                        newgrid[x][y] = tree
                    } else {
                        newgrid[x][y] = nil
                    }
                }
                
                
            }
        }
        
        //Spreading fire
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into fire if they're next to fire
                if grid[x][y] == tree {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 1 {
                            newgrid[x][y] = fire
                        }
                    }
                }
                
                if grid[x][y] == fire {
                    newgrid[x][y] = nil
                }
                
            }
        }
        
        //Actually updating the grid
        grid = newgrid
    }
    
    
    
    
    
    //Killing trees
    func noMercy() {
        newgrid = grid
        
        //Going through each cell
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //1% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.01 {
                        newgrid[x][y] = fire
                    } else {
                        if randomZeroToOne() <= 0.01 {
                            newgrid[x][y] = tree
                        } else {
                            newgrid[x][y] = nil
                        }
                    }
                }
                
                if grid[x][y] == wall {
                    newgrid[x][y] = wall
                }
                
                
            }
        }
        
        //Tree extermination
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into nil if they're next to wall
                if grid[x][y] == tree {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 3 {
                            newgrid[x][y] = nil
                        }
                    }
                }
                
            }
        }

        
        //Spreading fire
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into fire if they're next to fire
                if grid[x][y] == tree {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 1 {
                            newgrid[x][y] = fire
                        }
                    }
                }
                
                if grid[x][y] == fire {
                    newgrid[x][y] = nil
                }
                
            }
        }

        //Actually updating the grid
        grid = newgrid
        
    }
    
    
    
    
    
    //Jerk trees
    func jerkTrees() {
        newgrid = grid
        
        //Going through each cell
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //1% chance of tree generation
                if grid[x][y] == nil {
                    if randomZeroToOne() <= 0.03 {
                        newgrid[x][y] = strong
                    } else {
                        if randomZeroToOne() <= 0.03 {
                            newgrid[x][y] = jerk
                        } else {
                            if randomZeroToOne() <= 0.01 {
                                newgrid[x][y] = fire
                            } else {
                                newgrid[x][y] = nil
                            }
                        }
                    }
                }
                
            }
        }
        
        //Tree extermination
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into nil if they're next to wall
                if grid[x][y] == strong {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    var jerkCount = 0
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 3 {
                            newgrid[x][y] = nil
                        }
                        if treefire(x: xaxis, y: yaxis) == 5 {
                            jerkCount += 1
                        }
                    }
                    if jerkCount >= 4 {
                        newgrid[x][y] = nil
                    }
                }
                
                if grid[x][y] == jerk {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 3 {
                            newgrid[x][y] = nil
                        }
                    }
                }
                
            }
        }
        
        
        //Spreading fire
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                
                //Trees turn into fire if they're next to fire
                if grid[x][y] == fire {
                    newgrid[x][y] = nil
                }
                
                if grid[x][y] == jerk {
                    var neighbours = getNeighborPositions(x: x, y: y)
                    
                    //Checking if tree or not
                    for cells in 0..<neighbours.count {
                        //.x & .y are to access equivalent halves of tuples
                        var xaxis = neighbours[cells].x
                        var yaxis = neighbours[cells].y
                        if treefire(x: xaxis, y: yaxis) == 1 {
                            newgrid[x][y] = fire
                        }
                    }
                }
                
            }
        }
        
        //Actually updating the grid
        grid = newgrid

    }
}
