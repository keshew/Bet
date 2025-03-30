import SwiftUI

struct BetAddTaskView: View {
    @StateObject var betAddTaskModel =  BetAddTaskViewModel()
    @Environment(\.presentationMode) var presentationMode
  
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 230/255, green: 236/255, blue: 243/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.cancelButton)
                                    .resizable()
                                    .frame(width: 15, height: 20)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Text("Create New Task")
                            .PopBold(size: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: geometry.size.width,
                                   height: 0.3)
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 15) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Task Name")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betAddTaskModel.title,
                                                geometry: geometry,
                                                placeholder: "Enter task name")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Data & Time")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    DateTF(date: $betAddTaskModel.date,
                                           text: betAddTaskModel.currentDate,
                                           geometry: geometry)
                                    
                                    Spacer()
                                    
                                    TimeTF(time: $betAddTaskModel.time,
                                           text: betAddTaskModel.currentTime,
                                           geometry: geometry)
                                }
                                .padding(.horizontal)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Description")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                CustomTextView(text: $betAddTaskModel.description,
                                               geometry: geometry,
                                               placeholder: "Add description")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Priority")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        betAddTaskModel.isLow = true
                                        betAddTaskModel.isMed = false
                                        betAddTaskModel.isHigh = false
                                    }) {
                                        Rectangle()
                                            .fill(betAddTaskModel.isLow ? Color(red: 236/255, green: 203/255, blue: 153/255) : .white)
                                            .frame(height: 50)
                                            .cornerRadius(12)
                                            .padding(.horizontal, 7)
                                            .overlay {
                                                Text("Low")
                                                    .Pop(size: 16)
                                            }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        betAddTaskModel.isLow = false
                                        betAddTaskModel.isMed = true
                                        betAddTaskModel.isHigh = false
                                    }) {
                                        Rectangle()
                                            .fill(betAddTaskModel.isMed ? Color(red: 236/255, green: 203/255, blue: 153/255) : .white)
                                            .frame(height: 50)
                                            .cornerRadius(12)
                                            .padding(.horizontal, 7)
                                            .overlay {
                                                Text("Medium")
                                                    .Pop(size: 16)
                                            }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        betAddTaskModel.isLow = false
                                        betAddTaskModel.isMed = false
                                        betAddTaskModel.isHigh = true
                                    }) {
                                        Rectangle()
                                            .fill(betAddTaskModel.isHigh ? Color(red: 236/255, green: 203/255, blue: 153/255) : .white)
                                            .frame(height: 50)
                                            .cornerRadius(12)
                                            .padding(.horizontal, 7)
                                            .overlay {
                                                Text("High")
                                                    .Pop(size: 16)
                                            }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("Category")
                                    .Pop(size: 14)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            
                            SimpleDropDownView(hint: "Select a category",
                                                           options: ["Work",
                                                                     "Personal",
                                                                     "Health",
                                                                    "Finance",
                                                                     "Leisure"],
                                               selection: $betAddTaskModel.selection)
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("Reminder")
                                    .Pop(size: 14)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            TimeTF2(time: $betAddTaskModel.time2,
                                    text: betAddTaskModel.currentTime,
                                    geometry: geometry)
                        }
                        
                        Spacer(minLength: 15)
                        
                        HStack {
                                Text("Repeat task")
                                .Pop(size: 16)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Toggle("", isOn: $betAddTaskModel.isOn)
                                .toggleStyle(CustomToggleStyle())
                                .padding(.trailing, 15)
                        }
                        
                        Spacer(minLength: 15)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: geometry.size.width,
                                   height: 0.3)
                        
                        Spacer(minLength: 25)
                        
                        Button(action: {
                            if betAddTaskModel.saveTask() {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Rectangle()
                                .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                .frame(height: 56)
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                                .overlay {
                                    Text("Create Event")
                                        .Pop(size: 16, color: .white)
                                }
                        }
                        
                    }
                }
            }
            .alert(isPresented: $betAddTaskModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(betAddTaskModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    BetAddTaskView()
}

struct SimpleDropDownView: View {
    var hint: String
    var options: [String]
    @Binding var selection: String?
    @State private var showOptions = false
    @State private var zIndex: Double = 1000

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(selection ?? hint)
                    .foregroundStyle(Color(red: 48/255, green: 66/255, blue: 87/255))
                    .lineLimit(1)

                Spacer(minLength: 0)

                Image(.chevronDown)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .rotationEffect(.init(degrees: showOptions ? -180 : 0))
            }
            .padding(.horizontal, 15)
            .frame(height: 50)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showOptions.toggle()
                    zIndex += 1
                }
            }
            .zIndex(zIndex)

            if showOptions {
                OptionsView()
                    .zIndex(zIndex + 1)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
    }

    @ViewBuilder
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    Text(option)
                        .lineLimit(1)

                    Spacer(minLength: 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .frame(height: 40)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selection = option
                        showOptions = false
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .background(Color(red: 225/255, green: 225/255, blue: 225/255))
        .cornerRadius(10)
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 236/255, green: 203/255, blue: 153/255) : Color(red: 84/255, green: 88/255, blue: 91/255))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 23, height: 23)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}
