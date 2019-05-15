//
//  CalendarViewController.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    typealias WeekDay = CalendarViewModel.WeekDay

    // MARK: - IBOutlet
    @IBOutlet private weak var monthYearLabel: UILabel!
    @IBOutlet private weak var sundayLabel: UILabel!
    @IBOutlet private weak var mondayLabel: UILabel!
    @IBOutlet private weak var tuesdayLabel: UILabel!
    @IBOutlet private weak var wednesdayLabel: UILabel!
    @IBOutlet private weak var thursdayLabel: UILabel!
    @IBOutlet private weak var fridayLabel: UILabel!
    @IBOutlet private weak var saturdayLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Properties
    private let viewModel = CalendarViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction private func previousButtonTapped(_ button: UIButton) {
        viewModel.decreaseMonth()
        updateView()
    }

    @IBAction private func nextButtonTapped(_ button: UIButton) {
        viewModel.increaseMonth()
        updateView()
    }
}

// MARK: - Extension UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CalendarCollectionCell.self, indexPath: indexPath)
        let cellVM = viewModel.viewModelForItem(at: indexPath)
        cell.updateView(with: cellVM)
        if viewModel.isValidCell(indexPath) {
            cell.backgroundColor = .white
            /// TODO: - Cheat tạm thời để dấu đường line
            if let layers = cell.layer.sublayers {
                for layer in layers {
                    if layer.name == "thisIsBorderExternal" {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        } else {
            cell.backgroundColor = Color.calendarClearBackground
            cell.addExternalBorder(borderWidth: 1, borderColor: Color.calendarClearBackground)
        }
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.isValidCell(indexPath) else { return }
    }
}

// MARK: - Private functions
extension CalendarViewController {
    private func configureUI() {
        /// Header of calendar
        let headerLabels: [UILabel] = [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel]
        for index in 0 ..< WeekDay.count {
            headerLabels[index].text = WeekDay(rawValue: index + 1)?.displayName
        }
        updateMonthYearLabel()
        /// Collection view
        collectionView.register(nibWithCellClass: CalendarCollectionCell.self)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = collectionView.bounds.width / 7
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        let numberOfCell = viewModel.numberOfColumns.cgFloat
        collectionViewHeightConstraint.constant = numberOfCell * width
    }

    private func updateMonthYearLabel() {
        monthYearLabel.text = "\(viewModel.year)年\(viewModel.month)月"
    }

    private func updateView() {
        collectionView.reloadData()
        let width = collectionView.bounds.width / 7
        let numberOfCell = viewModel.numberOfColumns.cgFloat
        collectionViewHeightConstraint.constant = numberOfCell * width
        updateMonthYearLabel()
    }
}

extension UIView {
    // TODO: - Not working perfectly like this function said
    func addExternalBorder(borderWidth: CGFloat = 2.0, borderColor: UIColor = UIColor.white) {
        let externalBorder = CALayer()
        externalBorder.frame = CGRect(x: -borderWidth, y: -borderWidth, width: frame.size.width + 2 * borderWidth, height: frame.size.height + 2 * borderWidth)
        externalBorder.borderColor = borderColor.cgColor
        externalBorder.borderWidth = borderWidth
        externalBorder.name = "thisIsBorderExternal"
        layer.insertSublayer(externalBorder, at: 0)
        layer.masksToBounds = false
    }
}
