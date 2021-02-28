//
//  File.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import Foundation

class TasksListViewModel: ObservableObject {
    let userDefaultsHandler = UserDefaultsHandler()
    
    @Published var tasks: [Task] {
        didSet {
            userDefaultsHandler.saveData(tasks: tasks)
        }
    }

    init() {
        self.tasks = userDefaultsHandler.loadData()
    }
    
}
