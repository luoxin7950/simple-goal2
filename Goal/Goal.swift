//
//  Goal.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation

enum GoalType : Int {case Daily = 1, Weekly, Monthly, Yearly, Once}

class Goal : NSObject, NSCoding{

    var name : String = ""
    var isCompleted : Bool
    var type : GoalType
    //var type: String
    
    init(goalName name: String, isCompleted : Bool, type : GoalType)
    {
        self.name = name
        self.isCompleted = isCompleted
        //self.type = type
        self.type = type
    }
    

    func encode(with aCoder:NSCoder){
        aCoder.encode(name, forKey:"name")
        aCoder.encode(isCompleted, forKey:"isCompleted")
        aCoder.encode(type.rawValue, forKey:"type")
        //aCoder.encode(type, forKey:"type")
    }
    
    required init? (coder aDecoder: NSCoder)
    {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        //if ( aDecoder.decodeObject(forKey: "isCompleted") != nil)
        //{
            self.isCompleted = aDecoder.decodeBool(forKey: "isCompleted")
        //}
        //else
        //{
        //    self.isCompleted = false
        //}
        
        //if (aDecoder.decodeObject(forKey: "type") != nil)
        //{
            self.type = GoalType(rawValue: Int(aDecoder.decodeCInt(forKey: "type")))!
            //self.type = aDecoder.decodeObject(forKey: "type") as! String
        //}
        //else
        //{
        //   self.type = .Once
        //}
        
    }
    


}
