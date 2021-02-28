//
//  NewTask.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import SwiftUI

struct NewTask: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    
    var viewModel: TasksListViewModel
    
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                    TextEditor(text: $description)
                    DatePicker("Deadline", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    
                }
                Button(action: {
                    viewModel.tasks.append(Task(date: date, title: title, description: description, status: 0))
                    isPresented = false
                }, label: {
                    Text("Save")
                })
                .accentColor(Color("accentColor"))
                .navigationBarTitle("Add Task")
            }
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        TasksList()
    }
}
