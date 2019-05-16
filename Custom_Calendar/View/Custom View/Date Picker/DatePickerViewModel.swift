//
//  DatePickerViewModel.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import Foundation

final class DatePickerViewModel {

    enum PickerType: Int {
        case month
        case year

        var data: [String] {
            switch self {
            case .month:
                return ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"]
            case .year:
                var values: [String] = []
                for index in 1900 ... 2100 {
                    values.append("\(index)")
                }
                return values
            }
        }

        static let count: Int = {
            return PickerType.year.rawValue + 1
        }()
    }

    let numberOfComponent: Int = {
        return PickerType.count
    }()
}
