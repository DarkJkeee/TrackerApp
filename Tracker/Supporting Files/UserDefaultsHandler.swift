//
//  UserDefaults.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import Foundation

class UserDefaultsHandler {
    let userDefaults = UserDefaults.standard
    let key = "SavedTasks"
    
    func saveData(tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            userDefaults.set(encoded, forKey: key)
            UserDefaults(suiteName: "group.com.burstein.Tracker")?.set(encoded, forKey: "WidgetTask")
        }
    }
    
    func loadData() -> [Task] {
        var tasks = [Task]()
        if let items = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Task].self, from: items) {
                tasks = decoded
                return tasks
            }
        }
        return []
    }
    
    func loadDataWidget() -> [Task] {
        var tasks = [Task]()
        if let items = UserDefaults(suiteName: "group.com.burstein.Tracker")?.data(forKey: "WidgetTask") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Task].self, from: items) {
                tasks = decoded
                return tasks
            }
        }
        return []
    }
    
    func getTaskToWidget() -> Task? {
        let tasks = loadDataWidget()
        var nearestTask: Task? = tasks.count > 0 ? tasks[0] : nil
        
        if (tasks.count > 1) {
            for index in 0..<tasks.count - 1 {
                if (tasks[index].date < tasks[index + 1].date) {
                    nearestTask = tasks[index]
                }
            }
        }
        
        return nearestTask
    }
}
