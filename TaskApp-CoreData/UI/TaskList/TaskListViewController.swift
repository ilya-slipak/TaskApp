//
//  ViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class TaskListViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var newTaskButton: CustomButton!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        title = "Task list"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterIcon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonAction))
        let sortButton = UIBarButtonItem(image: UIImage(named: "sortIcon"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(sortButtonAction))
        
        navigationItem.rightBarButtonItems = [filterButton, sortButton]
    }
    
    // MARK: - Action Methods
    
    @IBAction private func newTaskButtonAction(_ sender: UIButton) {
        
        let controller = ScreenFactory.makeNewTaskScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func filterButtonAction() {
        
        let controller = ScreenFactory.makeTaskFilterScreen()
        present(controller, animated: true)
    }
    
    @objc
    private func sortButtonAction() {
        
        let controller = ScreenFactory.makeTaskSortScreen()
        present(controller, animated: true)
    }
}

