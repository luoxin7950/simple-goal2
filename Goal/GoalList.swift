//
//  GoalList.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation
import UIKit

class GoalList {
    
    // singleton
    static let goalList = GoalList()

    private let monthlyGoalUserKey = "monthlyGoalUserKey"
    private let weeklyGoalUserKey = "weeklyGoalUserKey"
    private let dailyGoalUserKey = "dailyGoalUserKey"
    private let yearlyGoalUserKey = "yearlyGoalUserKey"
    private let onceGoalUserKey = "onceGoalUserKey"
    
    // read only. call methods to change/set the list
    private(set) var dailyGoals : [Goal]
    private(set) var weeklyGoals : [Goal]
    private(set) var monthlyGoals : [Goal]
    private(set) var yearlyGoals : [Goal]
    private(set) var onceGoals : [Goal]

    static public func getGoalsFromUserDefault(userKey : String) -> [Goal]
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

    init()
    {
        //tmpchg testing clear user defaults
        //defaults.removeObject(forKey: dailyGoalUserKey)
        
        dailyGoals = GoalList.getGoalsFromUserDefault(userKey: dailyGoalUserKey)
        weeklyGoals = GoalList.getGoalsFromUserDefault(userKey: weeklyGoalUserKey)
        monthlyGoals = GoalList.getGoalsFromUserDefault(userKey: monthlyGoalUserKey)
        yearlyGoals = GoalList.getGoalsFromUserDefault(userKey: yearlyGoalUserKey)
        onceGoals = GoalList.getGoalsFromUserDefault(userKey: onceGoalUserKey)
    }
    
    
    // save changes to the user defaults
    // single point to save goals
    public func saveGoals()
    {
        let defaults = UserDefaults.standard
        
        // persist value
        let dailyGoalsData = NSKeyedArchiver.archivedData(withRootObject: dailyGoals)
        defaults.set(dailyGoalsData, forKey: dailyGoalUserKey)
        
        let weeklyGoalsData = NSKeyedArchiver.archivedData(withRootObject: weeklyGoals)
        defaults.set(weeklyGoalsData, forKey: weeklyGoalUserKey)
        
        let monthlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: monthlyGoals)
        defaults.set(monthlyGoalsData, forKey: monthlyGoalUserKey)
        
        let yearlyGoalsData = NSKeyedArchiver.archivedData(withRootObject: yearlyGoals)
        defaults.set(yearlyGoalsData, forKey: yearlyGoalUserKey)
        
        let onceGoalsData = NSKeyedArchiver.archivedData(withRootObject: onceGoals)
        defaults.set(onceGoalsData, forKey: onceGoalUserKey)
        
        defaults.synchronize()
    }
    
    
    // add a goal
    public func addGoal(goal: Goal)
    {
        switch goal.type {
        case .Daily:
            dailyGoals.append(goal) // allGoals reference this dailyGoals and should be updated as well
        case .Weekly:
            weeklyGoals.append(goal)
        case .Monthly:
            monthlyGoals.append(goal)
        case .Yearly:
            yearlyGoals.append(goal)
        case .Once:
            onceGoals.append(goal)
        }
        
        // better to raise event but right now just call method for simplicity
        saveGoals()
    }
    
    
    // delete a goal
    public func removeGoal(goal:Goal)
    {
        switch goal.type {
        case .Daily:
            if let index = dailyGoals.index(where: {$0.name == goal.name}) {
                dailyGoals.remove(at: index)
            }
        case .Weekly:
            if let index = weeklyGoals.index(where: {$0.name == goal.name}) {
                weeklyGoals.remove(at: index)
            }
        case .Monthly:
            if let index = monthlyGoals.index(where: {$0.name == goal.name}) {
                monthlyGoals.remove(at: index)
            }
        case .Yearly:
            if let index = yearlyGoals.index(where: {$0.name == goal.name}){
                yearlyGoals.remove(at: index)
            }
        case .Once:
            if let index = onceGoals.index(where : {$0.name == goal.name}){
                onceGoals.remove(at: index)
            }
        }
        
        // better to raise event but right now just call method for simplicity
        saveGoals()
    }
    
    
    // move a goal
    public func moveItem(goalType: GoalType, fromIndex from: Int, toIndex to: Int)
    {
        switch goalType {
        case GoalType.Daily :
            let item = dailyGoals[from]
            dailyGoals.remove(at: from)
            dailyGoals.insert(item, at: to)
        case .Weekly:
            let item = weeklyGoals[from]
            weeklyGoals.remove(at: from)
            weeklyGoals.insert(item, at: to)
        case .Monthly:
            let item = monthlyGoals[from]
            monthlyGoals.remove(at: from)
            monthlyGoals.insert(item, at: to)
        case .Yearly:
            let item = yearlyGoals[from]
            yearlyGoals.remove(at: from)
            yearlyGoals.insert(item, at: to)
        case .Once:
            let item = onceGoals[from]
            onceGoals.remove(at: from)
            onceGoals.insert(item, at: to)
        }
        
        // better to raise event but right now just call method for simplicity
        saveGoals()
    }
    


    
}

