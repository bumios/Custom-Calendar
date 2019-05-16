//
//  CalendarCollectionCellViewModel.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

final class CalendarCollectionCellViewModel {

    typealias WeekDay = CalendarViewModel.WeekDay

    enum SelectionStyle {
        case none
        case beginSelectionOnly
        case beginSelection
        case inSelection
        case endSelection
    }

    // MARK: - Properties
    let displayName: String
    let weekDay: WeekDay
    let selectionStyle: SelectionStyle
    let hasEvent: Bool

    // MARK: - Life cycle
    init(displayName: String, weekDay: WeekDay,
         selectionStyle: SelectionStyle = .none, hasEvent: Bool = false) {
        self.displayName = displayName
        self.weekDay = weekDay
        self.selectionStyle = selectionStyle
        self.hasEvent = hasEvent
    }
}
