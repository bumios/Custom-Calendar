//
//  DatePickerViewController.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class DatePickerViewController: UIViewController {

    typealias PickerType = DatePickerViewModel.PickerType

    // MARK: - IBOutlet
    @IBOutlet private weak var dateTextField: UITextField!

    // MARK: - Properties
    private let datePicker = UIPickerView()
    private let viewModel = DatePickerViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.dataSource = self
        datePicker.delegate = self
        dateTextField.inputView = datePicker
    }
}

// MARK: - Extension UIPickerViewDataSource
extension DatePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.numberOfComponent
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerType = PickerType(rawValue: component) else { return 0 }
        return pickerType.data.count
    }
}

// MARK: - Extension UIPickerViewDelegate
extension DatePickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pickerType = PickerType(rawValue: component) else { return nil }
        return pickerType.data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
