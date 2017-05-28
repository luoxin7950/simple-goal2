//
//  GoalLIstDao.swift
//  Goal
//
//  Created by LuoxinHua on 5/21/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation

class GoalListDao
{
    
    
    public func getGoals(userKey : String) -> [Goal]
    {
        let returnVal: [Goal]
        let defaults = UserDefaults.standard
        
        let nullableStoredGoals = defaults.object(forKey: userKey) as? Data
        
        if let storedGoals = nullableStoredGoals{
            // there is some goals stored. now unarchive them
            returnVal = NSKeyedUnarchiver.unarchiveObject(with: storedGoals) as! [Goal]
        }
        else{
            //no goal is stored
            returnVal = [Goal]()
        }
        
        return returnVal
    }
    
    public func saveGoal(goal: Goal)
    {
        
        
        
    }
    
    public func saveGoals(goalList : GoalList)
    {
        let defaults = UserDefaults.standard
        
        // persist value
        let dailyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalList.dailyGoals)
        defaults.set(dailyGoalsData, forKey: goalList.dailyGoalUserKey)
        
        let weeklyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalList.weeklyGoals)
        defaults.set(weeklyGoalsData, forKey: goalList.weeklyGoalUserKey)
        
        let monthlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalList.monthlyGoals)
        defaults.set(monthlyGoalsData, forKey: goalList.monthlyGoalUserKey)
        
        let yearlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalList.yearlyGoals)
        defaults.set(yearlyGoalsData, forKey: goalList.yearlyGoalUserKey)
        
        let onceGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalList.onceGoals)
        defaults.set(onceGoalsData, forKey: goalList.onceGoalUserKey)
        
        defaults.synchronize()
    }
    
}
