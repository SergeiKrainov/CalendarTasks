//
//  CalendarViewController.swift
//  CalendarTasks
//
//  Created by Sergey on 22.10.2021.
//

import UIKit
import FSCalendar
import RealmSwift

@available(iOS 13.4, *)
class CalendarViewController: UIViewController {
    
    var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHeightButton: UIButton = {
       let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(.gray , for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let tableView : UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()
    
    let realmManager = RealmManager.shared
    
    let idCalendarCell = "idCalendarCell"
    
    var calendarItems = [CalendarModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var toDoDate = Date() {
        didSet {
            self.getDay()
        }
    }
    
    func getDay() {
       
        let todayStartDate = toDoDate.timeIntervalSince1970 - toDoDate.getHour().secondRepresentation()
        let tomorrowStartDay = todayStartDate + 24 * 60 * 60
        calendarItems = self.realmManager.getToDo(from: todayStartDate, to: tomorrowStartDay).sorted {
            $0.calendarDate.timeIntervalSince1970 < $1.calendarDate.timeIntervalSince1970
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getDay()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Calendar"
        
  
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "idCalendarCell")
        
        setConstraints()
        swipeAction()
        
        showHeightButton.addTarget(self, action: #selector(showHeightButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        }
       
    }
    
    @objc func addButtonTapped () {
        
        let calendarOption = OptionsCalendarTableViewController()
        navigationController?.pushViewController(calendarOption, animated: true)
    }
    
    @objc func showHeightButtonTapped() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHeightButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHeightButton.setTitle("Open calendar", for: .normal)
        }
    }
    
 //MARK: SwipeGesturRecognizer
    
    func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHeightButtonTapped()
        case .down:
            showHeightButtonTapped()
        default: break
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource

@available(iOS 13.4, *)
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCalendarCell", for: indexPath) as! CalendarTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let model = self.calendarItems[indexPath.row]
        cell.taskName.text = model.calendarTaskName
        cell.descriptionName.text = model.calendarDescription
        cell.taskTime.text = dateFormatter.string(from: model.calendarDate) 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
}

//MARK: FSCalendarDataSource, FSCalendarDelegate

@available(iOS 13.4, *)
extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.toDoDate = date
    }
}

//MARK: SetConstraints

@available(iOS 13.4, *)
extension CalendarViewController {
    
    func setConstraints() {
        
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHeightButton)
        NSLayoutConstraint.activate([
            showHeightButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHeightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHeightButton.widthAnchor.constraint(equalToConstant: 100),
            showHeightButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHeightButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
}
