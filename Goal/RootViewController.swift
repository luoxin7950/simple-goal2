//
//  RootViewController.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UITextFieldDelegate {
    
    private let cellTableIdentifier = "CellTableIdentifier"
    private var cellPointSize: CGFloat!
    private var goalService : GoalService!

    // dummy test data for now tmpchg
//    var dailyGoalsTest = [
//        Goal(goalName: "Drink Water", isCompleted: false, type: .Daily),
//        Goal(goalName: "Work Out", isCompleted: false, type: .Daily),
//        Goal(goalName: "Drink Apple Juice", isCompleted: true, type: .Daily),
//        Goal(goalName: "Learn iOS Programming", isCompleted: false, type: .Daily),
//        Goal(goalName: "Write iOS App", isCompleted: false, type: .Daily)
//    ]
//    
//    var weeklyGoalsTest = [
//        Goal(goalName: "Maintain House", isCompleted: false, type: .Weekly),
//        Goal(goalName: "Research Finance", isCompleted: false, type: .Weekly),
//        Goal(goalName: "Retrospect", isCompleted: false, type: .Weekly)
//    ]
//    
//    var monthlyGoalsTest = [
//        Goal(goalName: "Clean House", isCompleted: false, type: .Monthly),
//        Goal(goalName: "I don't now yet", isCompleted: false, type: .Monthly)
//    ]
//    
//    var yearlyGoalsTest = [
//        Goal(goalName: "Get Married", isCompleted: false, type: .Yearly),
//        Goal(goalName: "Buy a new car", isCompleted: false, type: .Yearly)
//    ]
//    
//    var onceGoalsTest = [
//        Goal(goalName: "Just need to do it once", isCompleted: false, type: .Once),
//        Goal(goalName: "File tax return", isCompleted: false, type: .Once)
//    ]
    
    // end of test data
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(TextFieldCell.self,
                           forCellReuseIdentifier: cellTableIdentifier)
        let xib = UINib(nibName: "TextFieldCell", bundle: nil)
        tableView.register(xib,
                           forCellReuseIdentifier: cellTableIdentifier)
        
        // font style
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        goalService = GoalService()
        
        // setup test data
        //for goal in dailyGoalsTest
        //{
            //goalList.addGoal(goal: goal)
        //}
//        
//        for goal in weeklyGoalsTest
//        {
//            goalList.addGoal(goal: goal)
//        }
//        
//        for goal in monthlyGoalsTest
//        {
//            goalList.addGoal(goal: goal)
//        }
//        
//        for goal in yearlyGoalsTest
//        {
//            goalList.addGoal(goal: goal)
//        }
//        
//        for goal in onceGoalsTest
//        {
//            goalList.addGoal(goal: goal)
//        }

        // end of setup test data
        
        // always add empty goal at the end
        insertBlank()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    // return the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return goalService.getGoals(goalType: .Daily).count
        case 1:
            return goalService.getGoals(goalType: .Weekly).count
        case 2:
            return goalService.getGoals(goalType: .Monthly).count
        case 3:
            return goalService.getGoals(goalType: .Yearly).count
        case 4:
            return goalService.getGoals(goalType: .Once).count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableIdentifier, for: indexPath) as! TextFieldCell
        
            // Configure the cell...
            var currentGoal: Goal?
            switch indexPath.section {
            case 0:
                currentGoal = goalService.getGoals(goalType: .Daily)[indexPath.row]
            case 1:
                currentGoal = goalService.getGoals(goalType: .Weekly)[indexPath.row]
            case 2:
                currentGoal = goalService.getGoals(goalType: .Monthly)[indexPath.row]
            case 3:
                currentGoal = goalService.getGoals(goalType: .Yearly)[indexPath.row]
            case 4:
                currentGoal = goalService.getGoals(goalType: .Once)[indexPath.row]
            default:
                break;
            }
        
        cell.goal = currentGoal!.name
        cell.goalTextField.delegate = self
        
        //completed goal mark
        if currentGoal!.isCompleted {
            cell.goalTextField.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.goalTextField.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        return cell
    }
    // MARK: end of table view data source
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Daily Goals"
        case 1:
            return "Weekly Goals"
        case 2:
            return "Monthly Goals"
        case 3:
            return "Yearly Goals"
        case 4:
            return "Life Goals"
        default:
            return ""
        }
    }
    
    
    // MARK: end of table view delegate

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data model
            switch indexPath.section {
            case 0:
                goalService.removeGoal(goal: goalService.getGoals(goalType: .Daily)[indexPath.row])
            case 1:
                let goal = goalService.getGoals(goalType: .Weekly)[indexPath.row]
                goalService.removeGoal(goal: goal)
            case 2:
                let goal = goalService.getGoals(goalType: .Monthly)[indexPath.row]
                goalService.removeGoal(goal: goal)
            case 3:
                let goal = goalService.getGoals(goalType: .Yearly)[indexPath.row]
                goalService.removeGoal(goal: goal)
            case 4:
                let goal = goalService.getGoals(goalType: .Once)[indexPath.row]
                goalService.removeGoal(goal: goal)
            default:
                print("deleting goal.. invalid section number")
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with:.automatic)
            tableView.reloadSections(IndexSet(integer:indexPath.section), with:.automatic)
            tableView.endUpdates()
 
        } else if editingStyle == .insert {
            var count = 0
            // update data source
            switch indexPath.section {
            case 0:
                let goal = Goal(goalName: "", isCompleted: false, type: .Daily)
                goalService.addGoal(goal: goal)
                count = goalService.getGoals(goalType: .Daily).count
            case 1:
                let goal = Goal(goalName: "", isCompleted: false, type: .Weekly)
                goalService.addGoal(goal: goal)
                count = goalService.getGoals(goalType: .Weekly).count
            case 2:
                let goal = Goal(goalName: "", isCompleted: false, type: .Monthly)
                goalService.addGoal(goal: goal)
                count = goalService.getGoals(goalType: .Monthly).count
            case 3:
                let goal = Goal(goalName: "", isCompleted: false, type: .Yearly)
                goalService.addGoal(goal: goal)
                count = goalService.getGoals(goalType: .Yearly).count
            case 4:
                let goal = Goal(goalName: "", isCompleted: false, type: .Once)
                goalService.addGoal(goal: goal)
                count = goalService.getGoals(goalType: .Once).count
            default:
                print("commit...invalid section number")
            }
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row:count-1, section:indexPath.section)],
                                 with:.automatic)
            tableView.reloadRows(at: [IndexPath(row:count-2, section:indexPath.section)],
                                 with:.automatic)
            tableView.endUpdates()
            // crucial that this next bit be *outside* the updates block
            let cell = self.tableView.cellForRow(
                at: IndexPath(row:count-1, section:indexPath.section))
            (cell as! TextFieldCell).goalTextField.becomeFirstResponder()
            
        }    
    }
    
    /* MARK editable Content in Cells */
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCellEditingStyle {
            
                let ct = self.tableView(
                    tableView, numberOfRowsInSection:indexPath.section)
                if ct-1 == indexPath.row {
                    return .insert
                }
                return .delete;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

    // when is this triggered? the textfield lost focus? i am sure it occurs when the DONE button is clicked
    func textFieldDidEndEditing(_ textField: UITextField) {
        // some cell's text field has finished editing; which cell?
        var v : UIView = textField
        repeat { v = v.superview! } while !(v is UITableViewCell)
        let cell = v as! TextFieldCell
        // update data model to match
        // do we need to call save goal here?
        let ip = self.tableView.indexPath(for:cell)!
        switch ip.section {
        case 0:
            let goal = goalService.getGoals(goalType: .Daily)[ip.row]
            goal.name = cell.goalTextField.text!
            goalService.saveGoal(index: ip.row, goal: goal)
        case 1:
            let goal = goalService.getGoals(goalType: .Weekly)[ip.row]
            goal.name = cell.goalTextField.text!
            goalService.saveGoal(index: ip.row, goal: goal)
        case 2:
            let goal = goalService.getGoals(goalType: .Monthly)[ip.row]
            goal.name = cell.goalTextField.text!
            goalService.saveGoal(index: ip.row, goal:goal)
        case 3:
            let goal = goalService.getGoals(goalType: .Yearly)[ip.row]
            goal.name = cell.goalTextField.text!
            goalService.saveGoal(index: ip.row, goal:goal)
        case 4:
            let goal = goalService.getGoals(goalType: .Once)[ip.row]
            goal.name = cell.goalTextField.text!
            goalService.saveGoal(index: ip.row, goal:goal)
        default:
            break
        }
    }
    
    //mark a complete
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let completeAction = UITableViewRowAction(style: .default, title: "Complete", handler:
        {
            // begin of handler
            action, indexPath in
            
            switch indexPath.section {
            case 0:
                let goal = self.goalService.getGoals(goalType: .Daily)[indexPath.row]
                goal.isCompleted = !goal.isCompleted
                self.goalService.saveGoal(goal: goal)
            case 1:
                let goal = self.goalService.getGoals(goalType: .Weekly)[indexPath.row]
                goal.isCompleted = !goal.isCompleted
                self.goalService.saveGoal(goal: goal)
            case 2:
                let goal = self.goalService.getGoals(goalType: .Monthly)[indexPath.row]
                goal.isCompleted = !goal.isCompleted
                self.goalService.saveGoal(goal: goal)
            case 3:
                let goal = self.goalService.getGoals(goalType: .Yearly)[indexPath.row]
                goal.isCompleted = !goal.isCompleted
                self.goalService.saveGoal(goal: goal)
            case 4:
                let goal = self.goalService.getGoals(goalType: .Once)[indexPath.row]
                goal.isCompleted = !goal.isCompleted
                self.goalService.saveGoal(goal: goal)
            default:
                break
            }
            
            // refresh
            tableView.reloadData()
            
            // tell the table view it's done editing
            tableView.isEditing = false

            // end of handler
        })
        
        let deleteAction = UITableViewRowAction(style: .default, title:"Delete")
        {
            action, indexPath in
            self.tableView(self.tableView, commit:.delete, forRowAt:indexPath)
        }
      
        let actions = [completeAction, deleteAction]

        return actions
    }
    
    // rearrange rows
    //override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        //return true
    //}
    
    // rearrange rows?
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // take this opportunity to dismiss the keyboard if it is showing
        tableView.endEditing(true)
        if proposedDestinationIndexPath.section != sourceIndexPath.section
        {
            return IndexPath(row: sourceIndexPath.row, section: sourceIndexPath.section)
        }
        else{
            return proposedDestinationIndexPath
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        switch sourceIndexPath.section {
        case 0:
            goalService.moveItem(goalType: .Daily, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        case 1:
            goalService.moveItem(goalType: .Weekly, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        case 2:
            goalService.moveItem(goalType: .Monthly, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        case 3:
            goalService.moveItem(goalType: .Yearly, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        case 4:
            goalService.moveItem(goalType: .Once, fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        default:
            break
        }

    }
    
 
    /* MARK editable Content in Cells */
 
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // unitily method
    
    // always have a blank line so that insert sign will show up
    private func insertBlank(){
        
        if(goalService.getGoals(goalType: .Daily).count == 0)
        {
            goalService.addGoal(goal: Goal(goalName: "", isCompleted: false, type: .Daily))
        }
        
        if(goalService.getGoals(goalType: .Weekly).count == 0)
        {
            goalService.addGoal(goal: Goal(goalName: "", isCompleted: false, type: .Weekly))
        }
        
        if(goalService.getGoals(goalType: .Monthly).count == 0)
        {
            goalService.addGoal(goal: Goal(goalName: "", isCompleted: false, type: .Monthly))
        }
        
        if(goalService.getGoals(goalType: .Yearly).count == 0)
        {
            goalService.addGoal(goal: Goal(goalName: "", isCompleted: false, type: .Yearly))
        }
        
        if(goalService.getGoals(goalType: .Once).count == 0 )
        {
            goalService.addGoal(goal: Goal(goalName: "", isCompleted: false, type: .Once))
        }
        
    }

}
