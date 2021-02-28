//
//  TaskPage.swift
//  Tracker
//
//  Created by Глеб Бурштейн on 18.02.2021.
//

import SwiftUI

struct TaskPage: View {
    @Binding var task: Task
    @State var showActionSheet = false
    
    var body: some View {
        VStack {
            HStack() {
                TextField("Title", text: $task.title)
                    .font(.largeTitle)
                    .padding(.leading, 60)
                Button(action: {
                    showActionSheet.toggle()
                }, label: {
                    Image(systemName: "pencil")
                })
                .padding()
                .accentColor(Color("accentColor"))
            }
            .multilineTextAlignment(.center)
                
            TextEditor(text: $task.description)
                .font(.title2)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .padding()
            Spacer()
        }
        .sheet(isPresented: $showActionSheet, content: {
            VStack {
                DatePicker("Deadline", selection: $task.date, displayedComponents: [.date, .hourAndMinute])
                Picker(selection: $task.status, label: Text("Status"), content: {
                    Text("New").tag(0)
                    Text("In progress").tag(1)
                    Text("Done").tag(2)
                })
                Spacer()
                Button(action: {
                    showActionSheet.toggle()
                }, label: {
                    Text("Save")
                })
                .accentColor(Color("accentColor"))
            }
            .padding()
            .padding(.top, 40)
            Spacer()
        })
    }
}

struct TaskPage_Previews: PreviewProvider {
    static var previews: some View {
        TasksList()
            .preferredColorScheme(.dark)
    }
}
