//
//  ScreenFactory.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

enum ScreenFactory {
    
    static func makeTaskListScreen() -> TaskListViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskListViewController") as! TaskListViewController
        
        return controller
    }
    
    static func makeTaskDetailScreen(with task: Task) -> TaskDetailViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskDetailViewController") as! TaskDetailViewController
        controller.setup(with: task)
        
        return controller
    }
        
    static func makeEditTaskScreen() -> EditTaskViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "EditTaskViewController") as! EditTaskViewController
        
        return controller
    }
    
    static func makeNewTaskScreen() -> NewTaskViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "NewTaskViewController") as! NewTaskViewController
        
        return controller
    }
    
    static func makeTaskFilterScreen(selectedFilterRule: TaskFilterDataSource) -> TaskFilterViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskFilterViewController") as! TaskFilterViewController
        controller.setup(selectedFilterRule: selectedFilterRule)
        
        return controller
    }
    
    static func makeTaskSortScreen(with selectedSortRule: TaskSortDataSource) -> TaskSortViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskSortViewController") as! TaskSortViewController
        controller.setup(selectedSortRule: selectedSortRule)
        
        return controller
    }
    
    static func makePhotoPreviewScreen(with mediaModel: MediaModel) -> PhotoPreviewViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        controller.setup(with: mediaModel)
        
        return controller
    }
    
    static func makeVideoPreviewScreen() -> VideoPreviewViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "VideoPreviewViewController") as! VideoPreviewViewController
        
        return controller
    }
}
