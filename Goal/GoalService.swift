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
        goalRespository.addGoal(goal: goal)
    }
    
    public func saveGoal(goal: Goal){
        goalRespository.saveGoal(goal: goal)
    }
    
    public func saveGoal(index: Int, goal: Goal){
        goalRespository.saveGoal(index: index, goal: goal)
    }
    
    public func removeGoal(goal: Goal){
        goalRespository.removeGoal(goal: goal)
    }
    
    public func moveItem(goalType: GoalType, fromIndex from: Int, toIndex to: Int)
    {
       goalRespository.moveItem(goalType: goalType, fromIndex: from, toIndex : to)
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
