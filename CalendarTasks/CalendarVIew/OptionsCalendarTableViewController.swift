//
//  OptionsCalendarViewController.swift
//  CalendarTasks
//
//  Created by Sergey on 25.10.2021.
//

import UIKit

@available(iOS 13.4, *)
class OptionsCalendarTableViewController: UITableViewController {
    
    let idOptionsCalendarCell = "idOptionsCalendarCell"
    let idOptionsCalendarHeader = "idOptionsCalendarHeader"
    
    var calendarModel = CalendarModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsCalendarTableViewCell.self, forCellReuseIdentifier: idOptionsCalendarCell)
        tableView.register(HeaderOptionsCalendarTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsCalendarHeader)
        
        title = "Option Calendar"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func saveButtonTapped() {
        
        RealmManager.shared.saveCalemdarModel(model: calendarModel)
        calendarModel = CalendarModel()
        alertOk(title: "Success")
        tableView.reloadRows(at: [[0,0], [0,1], [1,0], [1,1]], with: .none)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsCalendarCell, for: indexPath) as! OptionsCalendarTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsCalendarHeader) as! HeaderOptionsCalendarTableViewCell
        header.headerConfigure(section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsCalendarTableViewCell
        
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
            self.calendarModel.calendarDate = date
        }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { (time) in
            self.calendarModel.calendarTime = time
        }
            
        case [1,0]:
            alertForCellName(label: cell.nameCellLabel, name: "Description", placeholder: "Description") { text in
                self.calendarModel.calendarDescription = text
        }
        case [1,1]:
            alertForCellName(label: cell.nameCellLabel, name: "Description", placeholder: "Description") { text in
                self.calendarModel.calendarTaskName = text
        }
        default:
            print("Error")
        }
    }
}
