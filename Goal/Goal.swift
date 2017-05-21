//
//  Goal.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import Foundation

// set as ini so it can be converted to int when storing in the user perference
enum GoalType : Int {case Daily = 1, Weekly, Monthly, Yearly, Once}


// implement NSCoding so that it can be stored in User Perference
class Goal : NSObject, NSCoding{

    var name : String = ""
    var isCompleted : Bool
    var type : GoalType
    
    // todo add sequence
    

    init(goalName name: String, isCompleted : Bool, type : GoalType)
    {
        self.name = name
        self.isCompleted = isCompleted
        self.type = type
    }
    

    //implement NSCoding
    func encode(with aCoder:NSCoder){
        aCoder.encode(name, forKey:"name")
        aCoder.encode(isCompleted, forKey:"isCompleted")
        
        // covert enum to int (rawValue)
        aCoder.encode(type.rawValue, forKey:"type")
    }
    
    //implementing NSCoding
    required init? (coder aDecoder: NSCoder)
    {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.isCompleted = aDecoder.decodeBool(forKey: "isCompleted")
        
        // convert int for enum
        self.type = GoalType(rawValue: Int(aDecoder.decodeCInt(forKey: "type")))!
    }
    


}
