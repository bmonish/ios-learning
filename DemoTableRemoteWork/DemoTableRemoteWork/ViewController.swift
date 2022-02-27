//
//  ViewController.swift
//  DemoTableRemoteWork
//
//  Created by monish-pt4649 on 02/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var statusData: [StatusDataModel] = [
        StatusDataModel(title: "Available for Collaboration",
                        iconCharacter: "laptopFill".iconCharacter(),
                        iconColor: .systemGreen),
        StatusDataModel(title: "Engaged at Work",
                        iconCharacter: "targetFill".iconCharacter(),
                        iconColor: .red),
        StatusDataModel(title: "Lunch break for 60 mins",
                        iconCharacter: "lunchFill".iconCharacter(),
                        iconColor: .orange),
        StatusDataModel(title: "Short break",
                        iconCharacter: "cupFill".iconCharacter(),
                        iconColor: .orange,
                        hasOptions: true,
                        options: [.fifteen, .thirty, .fortyFive, .sixty],
                        selectedOption: .fifteen,
                        isCollapsed: true),
        StatusDataModel(title: "DND",
                        iconCharacter: "doNotDisturb".iconCharacter(),
                        iconColor: .red,
                        hasOptions: true,
                        options: [.fifteen, .thirty, .fortyFive, .sixty],
                        selectedOption: .sixty,
                        isCollapsed: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(RemoteWorkCell.self, forCellReuseIdentifier: "remoteWorkCell")
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, DropDownActionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remoteWorkCell", for: indexPath) as! RemoteWorkCell
        cell.indexPath = indexPath
        cell.dropDownDelegate = self
        cell.updateCell(isCollapsed: statusData[indexPath.row].isCollapsed)
        cell.configure(statusIcon: statusData[indexPath.row].iconCharacter,
                       statusIconColor: statusData[indexPath.row].iconColor,
                       statusText: statusData[indexPath.row].title,
                       hasOptions: statusData[indexPath.row].hasOptions,
                       options: statusData[indexPath.row].options,
                       selectedOption: statusData[indexPath.row].selectedOption,
                       tag: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (statusData[indexPath.row].isCollapsed == false) {
            dropDownAction(indexPath: indexPath)
        }
    }
    
    func dropDownAction(indexPath: IndexPath) {
        statusData[indexPath.row].isCollapsed = !statusData[indexPath.row].isCollapsed
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let marginGuide = header.contentView.layoutMarginsGuide
        let label = UILabel()
        label.text = "Set your Status"
        label.textColor = .link
        label.translatesAutoresizingMaskIntoConstraints = false
        header.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
        ])
        
        return header
    }
}
