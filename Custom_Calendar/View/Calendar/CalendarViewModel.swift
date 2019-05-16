//
//  CalendarViewModel.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

final class CalendarViewModel {

    typealias SelectionStyle = CalendarCollectionCellViewModel.SelectionStyle

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
    var month: Int = 1
    var year: Int = 2019
    var selectedRange: [Int] = []
    /// Calculate variable
    var numberOfColumns: Int {
        let extraCell = getWeekdayType(year: year, month: month).extraCell
        let daysInMonth = Date.numberOfDays(month: month, year: year)
        let numberOfColums = ceil(((extraCell + daysInMonth).cgFloat / 7.cgFloat))
        return numberOfColums.int
    }

    // MARK: - Life cycle
    init() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .year], from: date)
        if let month = components.month, let year = components.year {
            self.month = month
            self.year = year
        }
    }

    // MARK: - Public
    func numberOfItems() -> Int {
        let roundedUpNumber = numberOfColumns.cgFloat * 7.cgFloat
        return roundedUpNumber.int
    }

    func viewModelForItem(at indexPath: IndexPath) -> CalendarCollectionCellViewModel {
        let row = indexPath.row
        var displayValue = ""
        var weekDay: WeekDay = .monday
        var selectionStyle: SelectionStyle = .none

        if isValidCell(indexPath) {
            let minimumCell = getWeekdayType(year: year, month: month).extraCell
            displayValue = "\(indexPath.row - minimumCell + 1)"
            weekDay = getWeekdayType(year: year, month: month, day: displayValue.int)

            if selectedRange.count == 1 {
                if row == selectedRange[0] {
                    selectionStyle = .beginSelectionOnly
                }
            } else if selectedRange.count == 2 {
                if row == selectedRange[0] {
                    selectionStyle = .beginSelection
                } else if row == selectedRange[1] {
                    selectionStyle = .endSelection
                } else {
                    if row > selectedRange[0] && row < selectedRange[1] {
                        selectionStyle = .inSelection
                    }
                }
            }
        }
        return CalendarCollectionCellViewModel(displayName: displayValue,
                                               weekDay: weekDay,
                                               selectionStyle: selectionStyle)
    }

    // MARK: - Calculate function
    func isValidCell(_ indexPath: IndexPath) -> Bool {
        let minimumCell = getWeekdayType(year: year, month: month).extraCell
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
        selectedRange.removeAll()
    }

    func decreaseMonth() {
        if month > 1 {
            month -= 1
        } else {
            year -= 1
            month = 12
        }
        selectedRange.removeAll()
    }

    func didSelect(at indexPath: IndexPath) {
        guard !selectedRange.contains(indexPath.row) else { return }
        let rowSelected = indexPath.row
        if selectedRange.count > 1 {
            let lowerRange = max(rowSelected, selectedRange[0]) - min(rowSelected, selectedRange[0])
            let higherRange = max(rowSelected, selectedRange[1]) - min(rowSelected, selectedRange[1])
            if lowerRange < higherRange {
                selectedRange.removeFirst()
            } else {
                selectedRange.removeLast()
            }
        }
        selectedRange.append(rowSelected)
        selectedRange = selectedRange.sorted()
    }

    // MARK: - Private
    /// Kiểm tra ngày hiện tại là ngày thứ mấy
    ///
    /// - Parameters:
    ///   - month: Tháng cần kiểm tra
    ///   - year: Năm cần kiểm tra
    ///   - day: Ngày (optional), mặc định là 1, đầu tháng
    /// - Returns: Thứ của ngày cần check
    private func getWeekdayType(year: Int, month: Int, day: Int = 1) -> WeekDay {
        let date = Date.dateFrom(year: year, month: month, day: day)
        let weekday = Calendar.current.component(.weekday, from: date)
        guard let weekDayType = WeekDay(rawValue: weekday) else { return .sunday }
        return weekDayType
    }
}
