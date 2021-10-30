//
//  RealmManager.swift
//  CalendarTasks
//
//  Created by Sergey on 27.10.2021.
//

import RealmSwift
import Foundation

class RealmManager {
    
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveCalemdarModel(model: CalendarModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func getToDo(from startDate: TimeInterval, to endDate: TimeInterval) -> [CalendarModel] {
        return self.localRealm.objects(CalendarModel.self).filter { model in
            model.calendarDate.timeIntervalSince1970 >= startDate && model.calendarDate.timeIntervalSince1970 < endDate
        }
    }
    
    
}
