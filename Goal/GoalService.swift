//
//  GoalService.swift
//  Goal
//
//  Created by Luoxin Hua on 5/28/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation

// calls repository
public class GoalService{

    //fields
    private var goalRespository: GoalRepository;
    //properties
    
    //ctor
    init(){
        goalRespository = GoalRepository()
    }
    
    //methods
    public func addGoal(goal: Goal){
        goalRespository.registerNew(goal: goal)
    }
    
    public func saveGoal(goal: Goal){
        goalRespository.registerAmended(goal: goal)
    }
    
    public func saveGoal(index: Int, goal: Goal){
        goalRespository.registerAmended(index: index, goal: goal)
    }
    
    public func removeGoal(goal: Goal){
        goalRespository.registerRemoved(goal: goal)
    }
    
    public func moveItem(goalType: GoalType, fromIndex from: Int, toIndex to: Int)
    {
       goalRespository.registerMove(goalType: goalType, fromIndex: from, toIndex : to)
    }
    
    public func getGoals(goalType: GoalType) -> [Goal]
    {
        return goalRespository.getGoals(goalType: goalType)
    }
    
    public func saveAllGoals()
    {
        goalRespository.saveAllGoals()
    }


}
