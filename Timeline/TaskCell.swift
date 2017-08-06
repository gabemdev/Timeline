//
//  TaskCell.swift
//  Timeline
//
//  Created by Gabriel Morales on 8/6/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskSubtitleLabel: UILabel!
    @IBOutlet weak var taskHourLabel: UILabel!
    @IBOutlet weak var taskCircleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        taskCircleView.layer.cornerRadius = taskCircleView.frame.size.width / 2
    }

    func configure(with task: Task) {
        
        let timeString = task.hour + task.time
        self.taskTitleLabel.text = task.title
        self.taskSubtitleLabel.text = task.subtitle
        self.taskHourLabel.text = timeString
        self.taskCircleView.backgroundColor = task.color
    }
}
