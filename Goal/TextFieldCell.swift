//
//  TextFieldCellTableViewCell.swift
//  Goal
//
//  Created by LuoxinHua on 3/18/17.
//  Copyright © 2017 LuoxinHua. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet var goalTextField: UITextField!
    
    var goal: String = ""{
        didSet {
            if (goal != oldValue )
            {
                goalTextField.text = goal
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didTransition(to state: UITableViewCellStateMask) {
        self.goalTextField.isEnabled = state.contains(.showingEditControlMask)
        super.didTransition(to:state)
    }

}
