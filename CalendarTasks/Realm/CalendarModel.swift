//
//  CalendarModel.swift
//  CalendarTasks
//
//  Created by Sergey on 27.10.2021.
//

import RealmSwift
import Foundation

class CalendarModel: Object {
    
    @Persisted var calendarDate = Date()
    @Persisted var calendarTime = Date()
    @Persisted var calendarDescription: String = "Unknown"
    @Persisted var calendarTaskName: String = "Unknown"
}
