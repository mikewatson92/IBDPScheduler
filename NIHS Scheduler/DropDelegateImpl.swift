//
//  DropDelegateImpl.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import Foundation
import SwiftUI

struct DropDelegateImpl: DropDelegate {
    var model: ModelData
    let item: ScheduleItem
    @Binding var listData: [CalendarViewModel]
    @Binding var current: ScheduleItem?
    
    func dropEntered(info: DropInfo) {
        guard var current = current, item != current else { return }
        let from = listData.first { cvm in
            return cvm.items.contains(current)
        }
        let to = listData.first { cvm in
            return cvm.items.contains(item)
        }
        
        guard var from = from, var to = to, from != to else { return }
        
        if let toItems = to.items.first(where: { $0.id == item.id }),
           toItems.id != current.id {
            let fromIndex = listData.firstIndex(of: from) ?? 0
            let toIndex = listData.firstIndex(of: to) ?? 0
            to.items.append(current)
            to.items.removeAll(where: { $0.name == nil })
            for var item in from.items {
                item.day = to.day
                item.period = to.period
            }
            from.items.removeAll(where: { $0.id == current.id })
            if from.items.isEmpty {
                from.items.append(ScheduleItem(name: nil))
            }
            listData[toIndex].items = to.items
            listData[fromIndex].items = from.items
            current.day = item.day
            current.period = item.period
            
            // Save data
            do {
                try FileManager().encodeToFile(name: "ModelData.json", content: model)
            } catch {
                print("Unable to save data!")
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}
