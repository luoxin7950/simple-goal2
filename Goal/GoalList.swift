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
        let optionalStoredGoals = defaults.object(forKey: userKey) as? NSData

        if let storedGoals = optionalStoredGoals{
            // there is some goals stored. now unarchive them
            returnVal = NSKeyedUnarchiver.unarchiveObject(with: storedGoals as Data) as! [Goal]
        }
        else{
             //no goal is stored
            returnVal = [Goal]()
        }
        
        return returnVal
    }

    init()
    {
        //let defaults = UserDefaults.standard
        
        //tmpchg claer user defaults
        //defaults.removeObject(forKey: dailyGoalUserKey)
        
        //let storedDailyGoals = defaults.object(forKey: dailyGoalUserKey) as? [String: Bool]
        //let storedDailyGoals = defaults.object(forKey: dailyGoalUserKey) as? NSData
        
        //let storedWeeklyGoals = defaults.object(forKey: weeklyGoalUserKey) as? [String: Bool]

        //let storedMonthlyGoals = defaults.object(forKey: monthlyGoalUserKey) as? [String: Bool]

        //let storedYearlyGoals = defaults.object(forKey: yearlyGoalUserKey) as? [String: Bool]

        //let storedOnceGoals = defaults.object(forKey: onceGoalUserKey) as? [String: Bool]

//        let tmpchg3 : [Goal]?
//        if (storedDailyGoals != nil)
//        {
//            let tmpchg = NSKeyedUnarchiver.unarchiveObject(with: (storedDailyGoals as Data?)!)
//            let tmpchg2 = tmpchg as! [Goal]?
//            tmpchg3 = tmpchg2
//        }
//        else{
//            tmpchg3 = nil
//        }

        // get persisted value
        //dailyGoals = (storedDailyGoals != nil) ? GoalList.mapDictionaryToGoals(dictionary : storedDailyGoals!, type: GoalType.Daily) : [Goal]()
        
//        let tmpchg3 : [Goal]?
//        tmpchg3 = NSKeyedUnarchiver.unarchiveObject(with: (storedWeeklyGoals as Data))
        
        
        //dailyGoals = (tmpchg3 != nil) ? tmpchg3! : [Goal]()
        dailyGoals = GoalList.getGoalsFromUserDefault(userKey: dailyGoalUserKey)
        weeklyGoals = GoalList.getGoalsFromUserDefault(userKey: weeklyGoalUserKey)
        monthlyGoals = GoalList.getGoalsFromUserDefault(userKey: monthlyGoalUserKey)
        yearlyGoals = GoalList.getGoalsFromUserDefault(userKey: yearlyGoalUserKey)
        onceGoals = GoalList.getGoalsFromUserDefault(userKey: onceGoalUserKey)
        
//        weeklyGoals = (storedWeeklyGoals != nil) ? GoalList.mapDictionaryToGoals(dictionary : storedWeeklyGoals!, type: GoalType.Weekly) : [Goal]()
//        monthlyGoals = (storedMonthlyGoals != nil) ? GoalList.mapDictionaryToGoals(dictionary : storedMonthlyGoals!, type: GoalType.Monthly) : [Goal]()
//        yearlyGoals = (storedYearlyGoals != nil) ?  GoalList.mapDictionaryToGoals(dictionary : storedYearlyGoals!, type: GoalType.Yearly) : [Goal]()
//        onceGoals = (storedOnceGoals != nil) ? GoalList.mapDictionaryToGoals(dictionary :
//            storedOnceGoals!, type: GoalType.Once) : [Goal]()
        
        
        // tmpchg the following code should be replaced by factory pattern to make class name a variable
        // init daily goals
//        if (allGoals[GoalType.Daily] != nil)
//        {
//            dailyGoals = allGoals[GoalType.Daily]!
//        }
//        else
//        {
//            dailyGoals = [Goal]()
//            allGoals[GoalType.Daily] = dailyGoals
//        }
//        
//        // init weekly goals
//        if (allGoals[GoalType.Weekly] != nil)
//        {
//            weeklyGoals = allGoals[GoalType.Weekly]!
//        }
//        else
//        {
//            weeklyGoals = [Goal]()
//            allGoals[GoalType.Weekly] = weeklyGoals
//        }
//        
//        // init monthly goals
//        if (allGoals[GoalType.Monthly] != nil)
//        {
//            monthlyGoals = allGoals[GoalType.Monthly]!
//        }
//        else
//        {
//            monthlyGoals = [Goal]()
//            allGoals[GoalType.Monthly] = monthlyGoals
//        }
//        
//        // init yearly goals
//        if (allGoals[GoalType.Yearly] != nil)
//        {
//            yearlyGoals = allGoals[GoalType.Yearly]!
//        }
//        else
//        {
//            yearlyGoals = [Goal]()
//            allGoals[GoalType.Yearly] = yearlyGoals
//        }
//        
//        // init once goals
//        if (allGoals[GoalType.Once] != nil)
//        {
//            onceGoals = allGoals[GoalType.Once]!
//        }
//        else
//        {
//            onceGoals = [Goal]()
//            allGoals[GoalType.Once] = onceGoals
//        }
        
    }
    
    
    // save changes to the user defaults
    public func saveGoals()
    {
        // currently only saving one goal but can save multiple goals
        let defaults = UserDefaults.standard
        
        // save persisted value
        //defaults.set(mapGoalsToDictionary(goals: dailyGoals), forKey: dailyGoalUserKey)
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
        
        //defaults.set(mapGoalsToDictionary(goals: weeklyGoals), forKey: weeklyGoalUserKey)
        //defaults.set(mapGoalsToDictionary(goals: monthlyGoals), forKey: monthlyGoalUserKey)
        //defaults.set(mapGoalsToDictionary(goals: yearlyGoals), forKey: yearlyGoalUserKey)
        //defaults.set(mapGoalsToDictionary(goals: onceGoals), forKey: onceGoalUserKey)
        
        defaults.synchronize()
    }
    
    
    // map list of goals to dictionary
    func mapGoalsToDictionary(goals: [Goal]) -> [String: Bool]
    {
        var dictionary = [String: Bool]()
        for goal in goals {
            dictionary[goal.name] = goal.isCompleted
        }
        
        return dictionary
    }
    
    
    static func mapDictionaryToGoals(dictionary: [String: Bool], type : GoalType) -> [Goal]
    {
        var array = [Goal]()
        for item in dictionary {
            let goal = Goal(goalName: item.key, isCompleted: item.value, type: type)
            array.append(goal)
        }
        return array
    }
    
    
    // add a goal
    func addGoal(goal: Goal)
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
    func removeGoal(goal:Goal)
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
    func moveItem(goalType: GoalType, fromIndex from: Int, toIndex to: Int)
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

