import SwiftUI

struct BetAddEventView: View {
    @StateObject var betAddEventModel =  BetAddEventViewModel()
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
                        
                        Text("Create Event")
                            .PopBold(size: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: geometry.size.width,
                                   height: 0.3)
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 15) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Event Name")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betAddEventModel.title,
                                                geometry: geometry,
                                                placeholder: "Add title")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Data & Time")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    DateTF(date: $betAddEventModel.date,
                                           text: betAddEventModel.currentDate,
                                           geometry: geometry)
                                    
                                    Spacer()
                                    
                                    TimeTF(time: $betAddEventModel.time,
                                           text: betAddEventModel.currentTime,
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
                                
                                CustomTextView(text: $betAddEventModel.description,
                                                geometry: geometry,
                                                placeholder: "Add description")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Location")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betAddEventModel.location,
                                                geometry: geometry,
                                                placeholder: "Add Location",
                                                isImage: true)
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Reminder")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                TimeTF2(time: $betAddEventModel.time2,
                                        text: betAddEventModel.currentTime,
                                        geometry: geometry)
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            Text("Event Color")
                                .Pop(size: 14)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    betAddEventModel.isColo1 = true
                                    betAddEventModel.isColo2 = false
                                    betAddEventModel.isColo3 = false
                                    betAddEventModel.isColo4 = false
                                }) {
                                    Group {
                                        if betAddEventModel.isColo1 {
                                            ZStack {
                                                Circle()
                                                    .fill(Color(red: 236/255, green: 203/255, blue: 153/255))
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .fill(Color(red: 236/255, green: 203/255, blue: 153/255))
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    betAddEventModel.isColo1 = false
                                    betAddEventModel.isColo2 = true
                                    betAddEventModel.isColo3 = false
                                    betAddEventModel.isColo4 = false
                                }) {
                                    Group {
                                        if betAddEventModel.isColo2 {
                                            ZStack {
                                                Circle()
                                                    .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    betAddEventModel.isColo1 = false
                                    betAddEventModel.isColo2 = false
                                    betAddEventModel.isColo3 = true
                                    betAddEventModel.isColo4 = false
                                }) {
                                    Group {
                                        if betAddEventModel.isColo3 {
                                            ZStack {
                                                Circle()
                                                    .fill(Color(red: 83/255, green: 109/255, blue: 137/255))
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .fill(Color(red: 83/255, green: 109/255, blue: 137/255))
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    betAddEventModel.isColo1 = false
                                    betAddEventModel.isColo2 = false
                                    betAddEventModel.isColo3 = false
                                    betAddEventModel.isColo4 = true
                                }) {
                                    Group {
                                        if betAddEventModel.isColo4 {
                                            ZStack {
                                                Circle()
                                                    .stroke(Color(red: 200/255, green: 211/255, blue: 222/255), lineWidth: 2)
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .frame(width: 24, height: 24)
                                        } else {
                                            Circle()
                                                .stroke(Color(red: 200/255, green: 211/255, blue: 222/255), lineWidth: 2)
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        
                        Spacer(minLength: 25)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: geometry.size.width,
                                   height: 0.3)
                        
                        Spacer(minLength: 25)
                        
                        Button(action: {
                            if betAddEventModel.saveEvent() {
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
            .alert(isPresented: $betAddEventModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(betAddEventModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    BetAddEventView()
}
