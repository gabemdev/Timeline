//
//  Task.swift
//  Timeline
//
//  Created by Gabriel Morales on 8/6/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

/// Category Enum
/// Used primarily for sorting filtering task items when tapping on menu buttons
///
/// - personal: Personal tasks
/// - project: Project tasks
/// - work: Work tasks
enum Category: String {
    case personal = "Personal"
    case project = "Project"
    case work = "Work"
}


/// Category Color Enum
/// Uses primarily for decorating the task cell
enum CategoryColor {
    case personal, project, work
    
    func color() -> UIColor {
        switch self {
        case .personal: return #colorLiteral(red: 0.8953927159, green: 0.6865332127, blue: 0.1563587189, alpha: 1)
        case .project: return #colorLiteral(red: 0.318880558, green: 0.7782427669, blue: 0.7472576499, alpha: 1)
        case .work: return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
}

struct Task {
    var title = ""
    var subtitle = ""
    var hour = ""
    var time = ""
    var category: Category?
    var color: UIColor?
}

extension Task {
    static let tasks = [catchUp, makeIcons, designExplorations, lunch, teamMeeting]
    
    static let catchUp = Task(title: "Catch up with Brian",
                              subtitle: "Mobile Project",
                              hour: "5",
                              time: "PM",
                              category: .personal,
                              color: CategoryColor.personal.color())
    
    static let makeIcons = Task(title: "Make new Icons",
                                subtitle: "Web App",
                                hour: "3",
                                time: "PM",
                                category: .project,
                                color: CategoryColor.project.color())
    
    static let designExplorations = Task(title: "Design Explorations",
                                         subtitle: "Company Website",
                                         hour: "2",
                                         time: "PM",
                                         category: .work,
                                         color: CategoryColor.work.color())
    
    static let lunch = Task(title: "Lunch with Mary",
                            subtitle: "Grill House",
                            hour: "12",
                            time: "PM",
                            category: .personal,
                            color: CategoryColor.personal.color())
    
    static let teamMeeting = Task(title: "Team meeting",
                                  subtitle: "Hangouts",
                                  hour: "10",
                                  time: "AM",
                                  category: .project,
                                  color: CategoryColor.project.color())
}
