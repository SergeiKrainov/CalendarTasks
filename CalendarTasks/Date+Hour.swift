//
//  Date+Hour.swift
//  CalendarTasks
//
//  Created by Sergey on 02.11.2021.
//

import Foundation


struct Hour {
    
    let hour, min, second : Double
    
    func stringRepresentation() -> String {
        return "\(hour):\(min):\(second)"
    }
    
    func secondRepresentation() -> Double {
        return hour * 60 * 60 + min * 60 + second
    }
}

extension Date {
    func getHour() -> Hour {
        let calendar = Calendar.current
        let hours = Double(calendar.component(.hour, from: self))
        let minutes = Double(calendar.component(.minute, from: self))
        let seconds = Double(calendar.component(.second, from: self))
        
        return Hour(hour: hours, min: minutes, second: seconds)
    }
    
}
