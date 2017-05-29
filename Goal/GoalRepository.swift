//
//  GoalList.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation
import UIKit

// unit of work
// repository
public class GoalRepository {

    private var goalListDao : GoalListDao
    
    public let monthlyGoalUserKey = "monthlyGoalUserKey"
    public let weeklyGoalUserKey = "weeklyGoalUserKey"
    public let dailyGoalUserKey = "dailyGoalUserKey"
    public let yearlyGoalUserKey = "yearlyGoalUserKey"
    public let onceGoalUserKey = "onceGoalUserKey"
    
    // read only. call methods to change/set the list
    private(set) var dailyGoals : [Goal]
    private(set) var weeklyGoals : [Goal]
    private(set) var monthlyGoals : [Goal]
    private(set) var yearlyGoals : [Goal]
    private(set) var onceGoals : [Goal]

    init()
    {
        //tmpchg testing clear user defaults
        //defaults.removeObject(forKey: dailyGoalUserKey)
        
        goalListDao = GoalListDao()
        
        dailyGoals = goalListDao.getGoals(userKey: dailyGoalUserKey)
        weeklyGoals = goalListDao.getGoals(userKey: weeklyGoalUserKey)
        monthlyGoals = goalListDao.getGoals(userKey: monthlyGoalUserKey)
        yearlyGoals = goalListDao.getGoals(userKey: yearlyGoalUserKey)
        onceGoals = goalListDao.getGoals(userKey: onceGoalUserKey)
        
    }

    
    // save changes to the user defaults
    // single point to save goals
    public func saveAllGoals()
    {
        goalListDao.saveGoals(goalRepository: self)
    }
    
    // get certain type of goals
    public func getGoals(goalType: GoalType) -> [Goal]
    {
        var returnGoals = [Goal]()
    
        switch goalType {
        case .Daily:
            returnGoals = dailyGoals
        case .Weekly:
            returnGoals = weeklyGoals
        case .Monthly:
            returnGoals = monthlyGoals
        case .Yearly:
            returnGoals = yearlyGoals
        case .Once:
            returnGoals = onceGoals
        }
    
        return returnGoals
    }
    
    // find a goal
    public func findGoal(goal: Goal) -> Int
    {
        var returnVal = -1
        
        switch goal.type {
        case .Daily:
            if let index = dailyGoals.index(where: {$0.name == goal.name}) {
                returnVal = index
            }
        case .Weekly:
            if let index = weeklyGoals.index(where: {$0.name == goal.name}) {
                returnVal = index
            }
        case .Monthly:
            if let index = monthlyGoals.index(where: {$0.name == goal.name}) {
                returnVal = index
            }
        case .Yearly:
            if let index = yearlyGoals.index(where: {$0.name == goal.name}){
                returnVal = index
            }
        case .Once:
            if let index = onceGoals.index(where : {$0.name == goal.name}){
                returnVal = index
            }
        }

        return returnVal
    }
    
    // register a new goal
    public func registerNew(goal: Goal)
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
        
        // tmpchg save to call dao
        saveAllGoals()
    }
    
    // register an amended goal
    public func registerAmended(goal: Goal)
    {
        let index = findGoal(goal: goal)
        if (index >= 0)
        {
            switch goal.type {
            case .Daily:
                dailyGoals[index] = goal
            case .Weekly:
                weeklyGoals[index] = goal
            case .Monthly:
                monthlyGoals[index] = goal
            case .Yearly:
                yearlyGoals[index] = goal
            case .Once:
                onceGoals[index] = goal
            }
            
            saveAllGoals()
        }
        else
        {
            // todo throw error here
        }
    }
    
    
    // register an amended goal
    public func registerAmended(index: Int, goal : Goal)
    {
        if (index >= 0)
        {
            switch goal.type {
            case .Daily:
                dailyGoals[index] = goal
            case .Weekly:
                weeklyGoals[index] = goal
            case .Monthly:
                monthlyGoals[index] = goal
            case .Yearly:
                yearlyGoals[index] = goal
            case .Once:
                onceGoals[index] = goal
            }
            
            saveAllGoals()
        }
        else
        {
            // todo throw error here
        }
    }
    
    // register a removed goal
    public func registerRemoved(goal:Goal)
    {
        let index = findGoal(goal: goal)
        if (index >= 0)
        {
            switch goal.type {
            case .Daily:
                dailyGoals.remove(at: index)
            case .Weekly:
                weeklyGoals.remove(at: index)
            case .Monthly:
                monthlyGoals.remove(at: index)
            case .Yearly:
                yearlyGoals.remove(at: index)
            case .Once:
                onceGoals.remove(at: index)
            }
        
        // better to raise event but right now just call method for simplicity
            saveAllGoals()
        }
        else{
            // todo throw error here
        }
    }
    
    
    // move a goal
    public func registerMove(goalType: GoalType, fromIndex from: Int, toIndex to: Int)
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
        saveAllGoals()
    }
    

}

