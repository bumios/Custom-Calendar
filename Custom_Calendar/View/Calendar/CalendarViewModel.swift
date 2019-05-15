//
//  CalendarViewModel.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

final class CalendarViewModel {
    enum WeekDay: Int {
        case sunday = 1     // Don't change this
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday

        var displayName: String {
            switch self {
            case .sunday: return "日"
            case .monday: return "月"
            case .tuesday: return "火"
            case .wednesday: return "水"
            case .thursday: return "木"
            case .friday: return "金"
            case .saturday: return "土"
            }
        }

        var extraCell: Int {
            return self.rawValue - 1
        }

        static let count: Int = {
            return WeekDay.saturday.rawValue
        }()
    }

    // MARK: - Properties
    var month: Int = 5
    var year: Int = 2019
    var selectedRange: [Int] = []
    /// Calculate variable
    var numberOfColumns: Int {
        let extraCell = firstWeekday(month: month, year: year).extraCell
        let daysInMonth = Date.numberOfDays(month: month, year: year)
        let numberOfColums = ceil(((extraCell + daysInMonth).cgFloat / 7.cgFloat))
        return numberOfColums.int
    }

    // MARK: - Public
    func numberOfItems() -> Int {
        let roundedUpNumber = numberOfColumns.cgFloat * 7.cgFloat
        return roundedUpNumber.int
    }

    func viewModelForItem(at indexPath: IndexPath) -> CalendarCollectionCellViewModel {
        var displayValue = ""
        if isValidCell(indexPath) {
            let minimumCell = firstWeekday(month: month, year: year).extraCell
            displayValue = "\(indexPath.row - minimumCell + 1)"
        }
        return CalendarCollectionCellViewModel(displayName: displayValue)
    }

    // MARK: - Calculate function
    func isValidCell(_ indexPath: IndexPath) -> Bool {
        let minimumCell = firstWeekday(month: month, year: year).extraCell
        let maximumCell = minimumCell + Date.numberOfDays(month: month, year: year)
        if indexPath.row >= minimumCell && indexPath.row < maximumCell {
            return true
        }
        return false
    }

    func increaseMonth() {
        if month < 12 {
            month += 1
        } else {
            month = 1
            year += 1
        }
    }

    func decreaseMonth() {
        if month <= 1 {
            year -= 1
            month = 12
        } else {
            month -= 1
        }
    }

    // MARK: - Private
    private func firstWeekday(month: Int, year: Int) -> WeekDay {
        let date = Date.dateFrom(month: month, year: year)
        let weekday = Calendar.current.component(.weekday, from: date)
        guard let weekDayType = WeekDay(rawValue: weekday) else { return .sunday }
        return weekDayType
    }
}
