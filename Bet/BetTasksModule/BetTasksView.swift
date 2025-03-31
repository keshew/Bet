import SwiftUI

struct BetTasksView: View {
    @StateObject var betTasksModel =  BetTasksViewModel()
    @Environment(\.presentationMode) var presentationModez
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Color(.white)
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width, height: 30)
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: geometry.size.width,
                               height: 0.5)
                        .opacity(0.5)
                        .offset(y: 8)
                 
                    Color(red: 230/255, green: 236/255, blue: 243/255)
                        .ignoresSafeArea()
                }
                
                VStack {
                    Text("Tasks")
                        .PopBold(size: 24)
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        ZStack {
                            VStack {
                                if UserDefaultsManager().isGuest() {
                                    Spacer(minLength: 40)
                                    
                                    Text("There are no task yet!")
                                        .PopBold(size: 22)
                                    
                                    Spacer(minLength: 20)
                                } else {
                                    if betTasksModel.tasks.isEmpty {
                                        Spacer(minLength: 40)
                                        
                                        Text("There are no task yet!")
                                            .PopBold(size: 22)
                                        
                                        Spacer(minLength: 20)
                                        
                                    } else {
                                        Spacer(minLength: 10)
                                        
                                        ForEach(betTasksModel.tasks) { task in
                                            TaskView(task: task) {
                                                betTasksModel.deleteTask(task)
                                            }
                                            .padding(.top, 5)
                                        }
                                    }
                                }
                                
                                Spacer(minLength: 20)
                                
                                Button(action: {
                                    betTasksModel.isAdd = true
                                }) {
                                    VStack {
                                        Image(.addButton)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        
                                        Text("Add task")
                                            .Pop(size: 16)
                                    }
                                }
                                .opacity(UserDefaultsManager().isGuest() ? 0.5 : 1)
                                .disabled(UserDefaultsManager().isGuest() ? true : false)
                                
                                Color(.clear)
                                    .frame(height: 60)
                            }
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .fullScreenCover(isPresented: $betTasksModel.isAdd) {
                BetAddTaskView()
            }
            
            .onChange(of: betTasksModel.isAdd) { _ in
                betTasksModel.loadTasks()
            }
        }
    }
}

#Preview {
    BetTasksView()
}

struct TaskView: View {
    let task: TaskModel
    @State private var isTapped = false
    var action: (() -> ())
    private var timeComponentsFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(height: 120)
                .cornerRadius(12)
                .padding(.horizontal, 10)
            
            HStack(spacing: 15) {
                VStack {
                    Button(action: {
                        withAnimation {
                            isTapped.toggle()
                            action()
                        }
                    }) {
                        if isTapped {
                            Circle()
                                .fill(Color(red: 238/255, green: 203/255, blue: 153/255))
                                .frame(width: 24, height: 24)
                                .padding(.leading)
                                .padding(.top)
                                .overlay {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 12))
                                        .padding(.leading, 15)
                                        .padding(.top)
                                }
                        } else {
                            Circle()
                                .stroke(Color(red: 238/255, green: 203/255, blue: 153/255), lineWidth: 2)
                                .frame(width: 24, height: 24)
                                .padding(.leading)
                                .padding(.top)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.leading, 10)
                
                VStack(alignment: .leading) {
                    Text(task.name)
                        .PopBold(size: 16)
                        .strikethrough(isTapped)
                        .animation(.easeInOut(duration: 0.2), value: isTapped)
                    
                    HStack {
                        Image(.time)
                            .resizable()
                            .frame(width: 14, height: 14)
                        
                        Text("\(timeComponentsFormatter.string(from: task.time))")
                            .Pop(size: 14)
                    }
                    
                    HStack(spacing: 10) {
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 229/255, green: 236/255, blue: 243/255))
                                .frame(width: 60, height: 24)
                                .cornerRadius(6)
                                .overlay {
                                    Text(task.category)
                                        .Pop(size: 12)
                                        .minimumScaleFactor(0.8)
                                }
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 238/255, green: 203/255, blue: 153/255))
                                .frame(width: 110, height: 24)
                                .cornerRadius(6)
                                .overlay {
                                    Text(getPriorityText(for: task.priority))
                                        .Pop(size: 12, color: .white)
                                }
                        }
                    }
                }
                .padding(.top, 3)
                
                Spacer()
            }
        }
        .frame(height: 120)
        .padding(.horizontal, 10)
        .opacity(isTapped ? 0.5 : 1)
    }

    private func getPriorityText(for priority: Priority) -> String {
        switch priority {
        case .Low:
            return "Low Priority"
        case .Medium:
            return "Medium Priority"
        case .Hight:
            return "High Priority"
        }
    }
}

