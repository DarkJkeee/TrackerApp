//
//  ContentView.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import SwiftUI

struct TasksList: View {
    @ObservedObject var tasksVM = TasksListViewModel()
    @State var isPresented: Bool = false
    @State var filterStatus: Int = 3
    
    var body: some View {
        NavigationView {
            List {
                ForEach((0 ..< tasksVM.tasks.count).filter({ filterStatus != 3 ? tasksVM.tasks[$0].status == filterStatus : true }), id: \.self) { index in
                    TaskCard(task: $tasksVM.tasks[index])
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        tasksVM.tasks.remove(at: index)
                    }
                }
            }
            .navigationBarTitle(Text("Your Tasks"))
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Menu {
                        Button(action: {
                            filterStatus = 0
                        }, label: {
                            Text("New")
                        })
                        Button(action: {
                            filterStatus = 1
                        }, label: {
                            Text("In progress")
                        })
                        Button(action: {
                            filterStatus = 2
                        }, label: {
                            Text("Done")
                        })
                        Button(action: {
                            filterStatus = 3
                        }, label: {
                            Text("All")
                        })
                    } label: {
                        Image(systemName: "book")
                    }
                }
            }
        }
        .accentColor(Color("accentColor"))
        .sheet(isPresented: $isPresented, content: {
            NewTask(isPresented: $isPresented, viewModel: tasksVM)
        })
    }
}

struct TaskCard: View {
    let statusColors = [Color.blue, Color.yellow, Color.green]
    
    @Binding var task: Task
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: TaskPage(task: $task),
                label: {
                    HStack {
                        Circle()
                            .fill(statusColors[task.status])
                            .frame(width: 10, height: 10)
                        Text(task.title)
                            .bold()
                        Spacer()
                        Text(task.date, style: .date)
                    }
                })
        }
        .frame(height: 70)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TasksList()
            .preferredColorScheme(.light)
    }
}

