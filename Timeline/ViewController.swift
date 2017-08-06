//
//  ViewController.swift
//  Timeline
//
//  Created by Gabriel Morales on 8/6/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /// Main Outlets
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuView: CircularView!
    
    /// Floating Action Button Outlets
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var mainButton: FloatingActionButton!
    
    /// Properties
    var buttons: [UIButton]!
    var tableData: [Task] = []
    var filteredData: [Task] = []
    
    /// Constants
    let topHeaderHeight: CGFloat = 325.0
    let loadIndexSet = IndexSet(integer: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [personalButton, clockButton, taskButton]
        
        self.tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -50)
        
        Data.getData { (data) in
            self.tableData = data
            self.filteredData = data
            self.tableView.reloadData()
        }
        closeButtonMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupHeaderView()
    }
}


// MARK: - Tableview Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.configure(with: task)
        return cell
    }
}


// MARK: - Helper Methods
extension ViewController {
    func closeButtonMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        personalButton.transform = CGAffineTransform(translationX: 0, y: -personalButton.frame.height - 20)
        clockButton.transform = CGAffineTransform(translationX: clockButton.frame.width + 20, y: 0)
        taskButton.transform = CGAffineTransform(translationX: 0, y: taskButton.frame.height + 20)
        resetFilter()
    }
    
    func expandButtonMenu() {
        self.menuView.transform = .identity
    }
    
    func setupHeaderView() {
        let width = self.view.frame.width
        let height = topHeaderHeight
        
        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: width, y: 0)
        let pointC = CGPoint(x: width, y: height)
        let pointD = CGPoint(x: 0, y: height * 0.75)
        
        let path = [pointA, pointB, pointC, pointD]
        addMask(view: topHeaderView, points: path)
        topHeaderView.clipsToBounds = true
    }
    
    func resetFilter() {
        self.filteredData = self.tableData
    }
}


// MARK: - IBActions
extension ViewController {
    @IBAction func onMenuButtonTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: { [weak self] in
            if self?.menuView.transform == .identity {
                self?.closeButtonMenu()
            } else {
                self?.expandButtonMenu()
            }
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseOut], animations: { [weak self] in
            if self?.menuView.transform == .identity {
                for button in (self?.buttons)! {
                    button.transform = .identity
                }
            }
        })
    }
    
    @IBAction func onTaskButtonTapped(_ sender: UIButton) {
        self.filteredData = self.tableData.filter { $0.category == Category.project }
    }
    
    @IBAction func onPersonalButtonTapped(_ sender: UIButton) {
        self.filteredData = self.tableData.filter { $0.category == Category.personal }
    }
    
    @IBAction func onClockButtonTapped(_ sender: UIButton) {
        self.filteredData = self.tableData.filter { $0.category == Category.work }
    }
    
    @IBAction func reloadTable() {
        self.tableView.reloadSections(loadIndexSet, with: .automatic)
    }
}



// MARK: - Mask Layer Helper
extension ViewController {
    func addMask(view: UIView, points: [CGPoint]) {
        let maskPath = UIBezierPath()
        maskPath.move(to: points[0])
        
        for i in 1..<points.count {
            maskPath.addLine(to: points[i])
        }
        
        maskPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
}
