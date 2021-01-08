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
    
    static func makeTaskDetailScreen() -> TaskDetailViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskDetailViewController") as! TaskDetailViewController
        
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
    
    static func makeTaskFilterScreen() -> TaskFilterViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskFilterViewController") as! TaskFilterViewController
        
        return controller
    }
    
    static func makeTaskSortScreen() -> TaskSortViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "TaskSortViewController") as! TaskSortViewController
        
        return controller
    }
    
    static func makePhotoPreviewScreen() -> PhotoPreviewViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        
        return controller
    }
    
    static func makeVideoPreviewScreen() -> VideoPreviewViewController {
        
        let controller =  UIStoryboard
            .makeController(name: "Main", identifier: "VideoPreviewViewController") as! VideoPreviewViewController
        
        return controller
    }
}
