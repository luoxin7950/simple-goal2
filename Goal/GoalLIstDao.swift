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
    
    
    public func saveGoals(goalRepository: GoalRepository)
    {
        let defaults = UserDefaults.standard
        
        // persist value
        let dailyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalRepository.dailyGoals)
        defaults.set(dailyGoalsData, forKey: goalRepository.dailyGoalUserKey)
        
        let weeklyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalRepository.weeklyGoals)
        defaults.set(weeklyGoalsData, forKey: goalRepository.weeklyGoalUserKey)
        
        let monthlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalRepository.monthlyGoals)
        defaults.set(monthlyGoalsData, forKey: goalRepository.monthlyGoalUserKey)
        
        let yearlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalRepository.yearlyGoals)
        defaults.set(yearlyGoalsData, forKey: goalRepository.yearlyGoalUserKey)
        
        let onceGoalsData = NSKeyedArchiver.archivedData(withRootObject: goalRepository.onceGoals)
        defaults.set(onceGoalsData, forKey: goalRepository.onceGoalUserKey)
        
        defaults.synchronize()
    }
    
}
