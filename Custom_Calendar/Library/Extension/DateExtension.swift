//
//  DateExtension.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/14/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    // MARK: - Custom Calendar
    static func numberOfDays(month: Int, year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }
        return range.count
    }

    static func dateFrom(year: Int, month: Int, day: Int = 1) -> Date {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { return Date() }
        return date
    }
}
