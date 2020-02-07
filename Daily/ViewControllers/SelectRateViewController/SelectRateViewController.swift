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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DayRateTableViewCell.nib, forCellReuseIdentifier: DayRateTableViewCell.nibName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configure(date: Date) {
        self.date = date
    }
}

extension SelectRateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SelectRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayRateTableViewCell.nibName, for: indexPath) as?  DayRateTableViewCell {
        cell.configure(noteRecord: noteRecord)
        return cell
        
        return UITableViewCell()
    }
}
