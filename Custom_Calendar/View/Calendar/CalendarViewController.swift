//
//  CalendarViewController.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    // MARK: - IBOutlet

    // MARK: - Properties
    private let viewModel = CalendarViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for month in 1 ... 12 {
            print("Tháng \(month): bắt đầu vào ngày \(firstWeekdayName(month: month, year: 2019))")
        }
    }
}

extension CalendarViewController {

    /// Đếm tổng số ngày của 1 tháng trong năm
    private func daysCount(month: Int, year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }
        return range.count
    }

    private func dateFrom(month: Int, year: Int) -> Date {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { return Date() }
        return date
    }

    private func firstWeekdayName(month: Int, year: Int) -> String {
        let date = dateFrom(month: month, year: year)
        let weekday = Calendar.current.component(.weekday, from: date)
//        let weekday = Calendar(identifier: .japanese).component(.weekday, from: date)
        switch weekday {
        case 1: return "Sunday"
        case 2: return "Monday"
        case 3: return "Tuesday"
        case 4: return "Wednesday"
        case 5: return "Thursday"
        case 6: return "Friday"
        default: return "Saturday"
        }
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
