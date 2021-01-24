//
//  ScreenFactory.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

enum ScreenFactory {
    
    static func makeTaskListScreen() -> TaskListViewController {
        
        let controller = TaskListViewController.instantiateFromStoryboard()
                    
        return controller
    }
    
    static func makeTaskDetailScreen(with task: Task) -> TaskDetailViewController {
        
        let controller = TaskDetailViewController.instantiateFromStoryboard()
        
        controller.setup(with: task)
        
        return controller
    }
        
    static func makeEditTaskScreen() -> EditTaskViewController {
        
        let controller = EditTaskViewController.instantiateFromStoryboard()
        
        return controller
    }
    
    static func makeNewTaskScreen() -> NewTaskViewController {
        
        let controller = NewTaskViewController.instantiateFromStoryboard()
        
        return controller
    }
    
    static func makePickerScreen(with dataSource: [PickerRuleModel], selectedIndex: Int) -> PickerViewController {
        
        let controller = PickerViewController.instantiateFromStoryboard()

        controller.setup(dataSource: dataSource, selectedIndex: selectedIndex)
        
        return controller
    }
    
    static func makePhotoPreviewScreen(with mediaModel: MediaModel) -> PhotoPreviewViewController {
        
        let controller = PhotoPreviewViewController.instantiateFromStoryboard()

        controller.setup(with: mediaModel)
        
        return controller
    }
    
    static func makeVideoPreviewScreen() -> VideoPreviewViewController {
        
        let controller = VideoPreviewViewController.instantiateFromStoryboard()
        
        return controller
    }
}
