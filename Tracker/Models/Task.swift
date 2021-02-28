//
//  Task.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import Foundation

struct Task : Identifiable, Encodable, Decodable {
    var id = UUID()
    var date: Date
    var title: String
    var description: String
    var status: Int
}
