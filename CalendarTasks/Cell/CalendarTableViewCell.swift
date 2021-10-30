//
//  CalendarTableViewCell.swift
//  CalendarTasks
//
//  Created by Sergey on 22.10.2021.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    
    var taskName = UILabel(text: "", font: .avenirNextDemiBold20())
    var descriptionName = UILabel(text: "", font: .avenirNext20())
    var taskTime = UILabel(text: "", font: .avenirNextDemiBold20())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        self.selectionStyle = .none
        
        descriptionName.numberOfLines = 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [taskName, descriptionName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskTime)
        NSLayoutConstraint.activate([
            taskTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            taskTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskTime.widthAnchor.constraint(equalToConstant: 100),
            taskTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
