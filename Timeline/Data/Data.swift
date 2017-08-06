//
//  Data.swift
//  Timeline
//
//  Created by Gabriel Morales on 8/6/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit


/// Mock up data class
class Data {
    static func getData(completion: @escaping([Task]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let tasks = Task.tasks
            DispatchQueue.main.async {
                completion(tasks)
            }
        }
    }
}
