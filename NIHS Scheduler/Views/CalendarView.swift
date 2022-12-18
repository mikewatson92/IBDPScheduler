//
//  CalendarView.swift
//  NIHS Scheduler
//
//  Created by ワトソン・マイク on 2022/12/08.
//

import SwiftUI
import UniformTypeIdentifiers

enum CalendarActiveSheet: Identifiable, CaseIterable {
    case addScheduleItem, editScheduleItem
    
    var id: Int {
        hashValue
    }
}

struct CalendarView: View {
    @EnvironmentObject var model: ModelData
    @State private var activeSheet: CalendarActiveSheet?
    @State private var modelsIndex: Int?
    @State private var itemIndex: Int?
    @State private var showPreIB = true
    @State private var showDP1 = true
    @State private var showDP2 = true
    @State private var showDelete = false
    @State private var dragging: ScheduleItem?
    private let fiveColumnGrid = Array(repeating: GridItem(.flexible(), spacing: 0), count: 5)
    
    var body: some View {
        HStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    Spacer()
                        .frame(height: 5)
                    ForEach(model.calendarModels.filter({ $0.day == nil })) { aModel in
                        ForEach(aModel.items) { item in
                            if (item.subject?.grade == .PreIB && showPreIB) || (item.subject?.grade == .DP1 && showDP1) || (item.subject?.grade == .DP2 && showDP2) {
                                if let name = item.name {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.mint)
                                            .background(Color.mint.opacity(0.1))
                                        VStack {
                                            Spacer()
                                            Text(name)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Spacer()
                                        }
                                    }
                                    .onTapGesture(count: 2) {
                                        modelsIndex = model.calendarModels.firstIndex(of: aModel)
                                        itemIndex = model.calendarModels[modelsIndex!].items.firstIndex(of: item)
                                        activeSheet = .editScheduleItem
                                    }
                                    .overlay(alignment: .topTrailing) {
                                        if showDelete {
                                            Button() {
                                                let deleteIndex = model.calendarModels.firstIndex(of: aModel)
                                                let deleteIndex2 = model.scheduleItems.firstIndex(of: aModel.items[0])
                                                model.calendarModels.remove(at: deleteIndex!)
                                                model.scheduleItems.remove(at: deleteIndex2!)
                                                let subjectIndex = model.subjects.firstIndex(of: item.subject!)
                                                model.subjects[subjectIndex!].numberOfLessons -= 1
                                                // Save data
                                                do {
                                                    try FileManager().encodeToFile(name: "ModelData.json", content: model)
                                                } catch {
                                                    print("Unable to save data!")
                                                }
                                            }
                                        label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                        .disabled(!showDelete)
                                        }
                                    }
                                    .background(item.color)
                                    .cornerRadius(4)
                                    .overlay(dragging?.id == item.id ? Color.cyan.opacity(0.3) : Color.clear)
                                    .onDrag {
                                        self.dragging = item
                                        return NSItemProvider(object: item.id as NSString)
                                    }
                                    .onDrop(of: [UTType.text],
                                            delegate: DropDelegateImpl(model: model, item: item,
                                                                       listData: $model.calendarModels,
                                                                       current: $dragging))
                                    
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.mint)
                                            .background(Color.mint.opacity(0.1))
                                        
                                        VStack {
                                            Spacer()
                                            Text("")
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Spacer()
                                        }
                                        .onDrop(of: [UTType.text],
                                                delegate: DropDelegateImpl(model: model, item: item,
                                                                           listData: $model.calendarModels,
                                                                           current: $dragging))
                                    }
                                }
                            }
                        }
                        
                        if aModel.items.isEmpty {
                            Spacer()
                        }
                    }
                    .frame(width: 150, height: 75)
                    .padding([.top], 1)
                }
                .frame(width: 175)
            }
            
            ScrollView(.horizontal) {
                Grid {
                    GridRow {
                        Text("")
                        ForEach(Day.allCases) { day in
                            Text(day.rawValue)
                        }
                    }
                    ForEach(Period.allCases) { period in
                        GridRow {
                            Text(period.rawValue)
                            ForEach(model.calendarModels.filter({ $0.period == period })) { aModel in
                                HStack{
                                    ForEach(aModel.items) { item in
                                        if (item.subject?.grade == .PreIB && showPreIB) || (item.subject?.grade == .DP1 && showDP1) || (item.subject?.grade == .DP2 && showDP2) {
                                            if let name = item.name {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.mint)
                                                        .background(Color.mint.opacity(0.1))
                                                    VStack {
                                                        Text(name)
                                                            .frame(maxWidth: .infinity, alignment: .center)
                                                            .padding(1)
                                                    }
                                                }
                                                .onTapGesture(count: 2) {
                                                    modelsIndex = model.calendarModels.firstIndex(of: aModel)
                                                    itemIndex = model.calendarModels[modelsIndex!].items.firstIndex(of: item)
                                                    activeSheet = .editScheduleItem
                                                }
                                                .overlay(alignment: .topTrailing) {
                                                    if showDelete {
                                                        Button() {
                                                            let deleteModelIndex = model.calendarModels.firstIndex(of: aModel)
                                                            let deleteItemIndex = model.calendarModels[deleteModelIndex!].items.firstIndex(of: item)
                                                            model.calendarModels[deleteModelIndex!].items.remove(at: deleteItemIndex!)
                                                            model.scheduleItems.removeAll(where: { $0 == item })
                                                            let subjectIndex = model.subjects.firstIndex(of: item.subject!)
                                                            model.subjects[subjectIndex!].numberOfLessons -= 1
                                                            
                                                            if model.calendarModels[deleteModelIndex!].items.isEmpty {
                                                                model.calendarModels[deleteModelIndex!].items.append(ScheduleItem(name: nil))
                                                            }
                                                            // Save data
                                                            do {
                                                                try FileManager().encodeToFile(name: "ModelData.json", content: model)
                                                            } catch {
                                                                print("Unable to save data!")
                                                            }
                                                        }
                                                    label: {
                                                        Image(systemName: "minus.circle.fill")
                                                            .foregroundColor(.red)
                                                    }
                                                    .disabled(!showDelete)
                                                    }
                                                }
                                                .background(item.color)
                                                .cornerRadius(4)
                                                .overlay(dragging?.id == item.id ? Color.green.opacity(0.3) : Color.clear)
                                                .onDrag {
                                                    self.dragging = item
                                                    return NSItemProvider(object: item.id as NSString)
                                                }
                                                .onDrop(of: [UTType.text],
                                                        delegate: DropDelegateImpl(model: model, item: item,
                                                                                   listData: $model.calendarModels,
                                                                                   current: $dragging))
                                            }
                                        } else {
                                            if aModel.items[0].name == nil || (item.subject?.grade == .PreIB && showPreIB) || (item.subject?.grade == .DP1 && showDP1) || (item.subject?.grade == .DP2 && showDP2) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 4)
                                                        .stroke(Color.mint)
                                                        .background(Color.mint.opacity(0.1))
                                                    
                                                    VStack {
                                                        Spacer()
                                                        Text("")
                                                            .frame(maxWidth: .infinity, alignment: .center)
                                                        Spacer()
                                                    }
                                                }
                                                .onDrop(of: [UTType.text],
                                                        delegate: DropDelegateImpl(model: model, item: item,
                                                                                   listData: $model.calendarModels,
                                                                                   current: $dragging))
                                            }
                                        }
                                    }
                                }
                                if aModel.items.isEmpty {
                                    Spacer()
                                }
                            }
                            .frame(width: 750, alignment: .center)
                            
                        }
                        .animation(.default, value: model.calendarModels)
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup {
                Menu() {
                    Toggle(isOn: $showPreIB) {
                        Text("Pre IB")
                    }
                    Toggle(isOn: $showDP1) {
                        Text("DP 1")
                    }
                    Toggle(isOn: $showDP2) {
                        Text("DP 2")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                }
                
                Button() {
                    showDelete.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                
                Button() {
                    activeSheet = .addScheduleItem
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.green)
                }
            }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .addScheduleItem:
                AddScheduleItem(activeSheet: $activeSheet, modelsIndex: $modelsIndex, itemIndex: $itemIndex)
                    .environmentObject(model)
                    .frame(width: 500, height: 250)
            case .editScheduleItem:
                ScheduleItemDetailView(activeSheet: $activeSheet, modelsIndex: $modelsIndex, itemIndex: $itemIndex)
                    .environmentObject(model)
                    .frame(width: 500, height: 500)
            }
        }
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ModelData())
    }
}

