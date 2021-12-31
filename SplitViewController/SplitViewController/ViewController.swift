//
//  ViewController.swift
//  SplitViewController
//
//  Created by monish-pt4649 on 31/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    var button: UIButton!
    let splitVC = UISplitViewController(style: .doubleColumn)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Creating a Button which presents the Split View Controller
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        view.addSubview(button)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc
    func didTapButton(){
        splitVC.modalPresentationStyle = .fullScreen
        
        // Creating View Controllers
        let menuVC = MenuController(style: .plain)
        menuVC.delegate = self
        
        let secondVC = UIViewController()
        secondVC.title = "Home "
        secondVC.view.backgroundColor = .systemBlue
        
        // Setting View Controllers
        splitVC.viewControllers = [
            UINavigationController(rootViewController: menuVC),
            UINavigationController(rootViewController: secondVC)
        ]
        
        present(splitVC, animated: true)
    }
    
    // Misc function to center button when rotated
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button.center = view.center
    }

}

extension ViewController: MenuControllerDelegate {
    func didTapMenuItem(at index: Int, title: String?) {
        
        (splitVC.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        vc.title = title
        
        (splitVC.viewControllers.last as? UINavigationController)?.pushViewController(vc, animated: true)
    }
    
//    func getSplitVC() -> UISplitViewController {
//        print("Returning SplitVC")
//        return splitVC
//    }
}

protocol MenuControllerDelegate: AnyObject  {
    func didTapMenuItem(at index: Int, title: String?)
//    func getSplitVC() -> UISplitViewController
}

class MenuController: UITableViewController {
    
    weak var delegate: MenuControllerDelegate?
    
//    var closeMenuButton: UIBarButtonItem!
    
    override init(style: UITableView.Style) {
        super.init(style: style)
//        closeMenuButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(hideMenu))
//        navigationItem.rightBarButtonItem = closeMenuButton
        title = "Menu"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
//    @objc
//    func hideMenu() {
//        print("Hide Menu is called")
//        let sVC = delegate?.getSplitVC()
//        sVC?.preferredDisplayMode = UISplitViewController.DisplayMode.secondaryOnly
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Option \(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellLabel = tableView.cellForRow(at: indexPath)?.textLabel?.text
        delegate?.didTapMenuItem(at: indexPath.row, title: cellLabel)
    }
}
