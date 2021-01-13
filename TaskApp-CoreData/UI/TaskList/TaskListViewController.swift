//
//  ViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit
import CoreData

final class TaskListViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var newTaskButton: CustomButton!
    
    // MARK: - Private Properties
    
    private var sortRule: TaskSortDataSource = .createdAtAscending
    private var filterRule: TaskFilterDataSource = .all
    private lazy var fetchedResultsController:
        NSFetchedResultsController<Task> = {
            
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.sortDescriptors = sortRule.sortDescriptors
            fetchRequest.predicate = filterRule.predicate
            
            let fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: DatabaseManager.shared.context,
                sectionNameKeyPath: #keyPath(Task.status),
                cacheName: nil)
            fetchedResultsController.delegate = self
            
            return fetchedResultsController
        }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchTasks()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        title = "Task list"
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        
        let cellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        let cellReuseIdentifier = TaskTableViewCell.reuseIdentifier
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
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
    
    private func fetchTasks(with sortRule: TaskSortDataSource? = nil, filterRule: TaskFilterDataSource? = nil) {
        
        let sortRule = sortRule ?? self.sortRule
        let filterRule = filterRule ?? self.filterRule
        fetchedResultsController.fetchRequest.sortDescriptors = sortRule.sortDescriptors
        fetchedResultsController.fetchRequest.predicate = filterRule.predicate
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    private func deleteTask(at indexPath: IndexPath) {
        
        let task = fetchedResultsController.object(at: indexPath)
        TaskDatabaseManager.shared.deleteTask(task)
    }
    
    private func showTaskDetail(with task: Task) {
        
        let controller = ScreenFactory.makeTaskDetailScreen(with: task)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Action Methods
    
    @IBAction private func newTaskButtonAction(_ sender: UIButton) {
        
        let controller = ScreenFactory.makeNewTaskScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func filterButtonAction() {
        
        let controller = ScreenFactory.makeTaskFilterScreen(selectedFilterRule: filterRule)
        controller.onSelectFilterRule = { [weak self] filterRule in
            self?.filterRule = filterRule
            self?.fetchTasks(filterRule: filterRule)
        }
        present(controller, animated: true)
    }
    
    @objc
    private func sortButtonAction() {
        
        let controller = ScreenFactory.makeTaskSortScreen(with: sortRule)
        controller.onSelectSortRule = { [weak self] sortRule in
            self?.sortRule = sortRule
            self?.fetchTasks(with: sortRule)
        }
        present(controller, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo =
                fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = TaskTableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TaskTableViewCell
        let task = fetchedResultsController.object(at: indexPath)
        cell.configure(with: task)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionInfo = Int16(fetchedResultsController.sections?[section].name ?? "") ?? 0
        let section = Task.Status(rawValue: sectionInfo)
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        titleLabel.text = section?.title
        
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = fetchedResultsController.object(at: indexPath)
        showTaskDetail(with: task)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
            
            self?.deleteTask(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TaskListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller:
                                        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller:
                        NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: break
        }
    }
    
    func controller(_ controller:
                        NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! TaskTableViewCell
            let task = fetchedResultsController.object(at: indexPath!)
            cell.configure(with: task)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
        }
    }
    
    func controllerDidChangeContent(_ controller:
                                        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
