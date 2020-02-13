//
//  SelectRateViewController.swift
//  Daily
//
//  Created by Никифоров Василий Петрович on 07.02.2020.
//  Copyright © 2020 buldog.team. All rights reserved.
//

import UIKit

protocol SelectRateDelegate {
    func rateDidChange()
}

class SelectRateViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var date: Date = Date()
    private var dayRate: DayRate = .noRate
    private var delegate: SelectRateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DayRateTableViewCell.nib, forCellReuseIdentifier: DayRateTableViewCell.nibName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configure(date: Date, delegate: SelectRateDelegate?) {
        self.date = date
        self.delegate = delegate
        
        dayRate = Day.getDay(date: date)?.rate ?? DayRate.noRate
    }
}

extension SelectRateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Day.setDayRate(dayDate: date.startOfDay, rate: DayRate.allCases[indexPath.row])
        delegate?.rateDidChange()
        dismiss()
    }
}

extension SelectRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayRate.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayRateTableViewCell.nibName, for: indexPath) as! DayRateTableViewCell
        let currentDrovintRate =  DayRate.allCases[indexPath.row]
        cell.configure(for: DayRateTableVievCellViewModel(
            dayRate: currentDrovintRate,
            isSelected: currentDrovintRate == dayRate
        ))
        return cell
    }
}
