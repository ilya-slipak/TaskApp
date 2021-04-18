//
//  ScreenFactory.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

enum ScreenFactory {
    
    static func makeTaskListScreen() -> TaskListViewController {
        
        let controller = TaskListViewController.makeFromStoryboard()
                    
        return controller
    }
    
    static func makeTaskDetailScreen(with task: Task) -> TaskDetailViewController {
        
        let controller = TaskDetailViewController.makeFromStoryboard()
        
        controller.setup(with: task)
        
        return controller
    }
        
    static func makeEditTaskScreen() -> EditTaskViewController {
        
        let controller = EditTaskViewController.makeFromStoryboard()
        
        return controller
    }
    
    static func makeNewTaskScreen() -> NewTaskViewController {
        
        let controller = NewTaskViewController.makeFromStoryboard()
        
        return controller
    }
    
    static func makePickerScreen(with dataSource: [PickerRuleModel], selectedIndex: Int) -> PickerViewController {
        
        let controller = PickerViewController.makeFromStoryboard()

        controller.setup(dataSource: dataSource, selectedIndex: selectedIndex)
        
        return controller
    }
    
    static func makePhotoPreviewScreen(with mediaModel: MediaModel) -> PhotoPreviewViewController {
        
        let controller = PhotoPreviewViewController.makeFromStoryboard()

        controller.setup(with: mediaModel)
        
        return controller
    }
    
    static func makeVideoPreviewScreen() -> VideoPreviewViewController {
        
        let controller = VideoPreviewViewController.makeFromStoryboard()
        
        return controller
    }
}
