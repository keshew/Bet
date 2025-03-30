import SwiftUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var isImage = false
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.white)
                .frame(height: 50)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Poppins-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                HStack(spacing: -20) {
                    if isImage {
                        Image(.map)
                            .resizable()
                            .frame(width: 12, height: 16)
                            .padding(.leading, 30)
                    }
                    
                    Text(placeholder)
                        .Pop(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
                }
            }
        }
    }
}

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var isImage = true

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.white)
                .frame(height: 90)
                .cornerRadius(12)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 1)
                        .padding(.horizontal)
                }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(.white)
                .padding(.horizontal, 30)
                .padding(.top, 5)
                .frame(height: 90)
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundColor(Color(red: 172/255, green: 174/255, blue: 188/255))
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundStyle(Color(red: 172/255, green: 174/255, blue: 188/255))
                        .padding(.leading, 30)
                        .padding(.top)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
    }
}

struct DateTF: View {
    @Binding var date: Date
    var text: String
    var geometry: GeometryProxy

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 175, height: 50)
                    .cornerRadius(9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color(red: 156/255, green: 177/255, blue: 188/255), lineWidth: 1)
                    )
                
                HStack {
                    Text("\(text)")
                    
                    Spacer()
                    
                    Image(.date)
                        .resizable()
                        .frame(width: 14, height: 16)
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 50)
            }
            .labelsHidden()
            .frame(width: 175, height: 50)
        }
    }
}

struct TimeTF: View {
    @Binding var time: Date
    var text: String
    var geometry: GeometryProxy

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 175, height: 50)
                    .cornerRadius(9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color(red: 156/255, green: 177/255, blue: 188/255), lineWidth: 1)
                    )
                
                HStack {
                    Text(time.formatted(date: .omitted, time: .shortened))
                    
                    Spacer()
                    
                    Image(.time)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Time",
                    selection: $time,
                    in: Date()...,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 50)
            }
            .labelsHidden()
            .frame(width: 175, height: 50)
        }
    }
}

struct TimeTF2: View {
    @Binding var time: Date
    var text: String
    var geometry: GeometryProxy
    
    private var timeBinding: Binding<Date> {
        Binding(
            get: { self.time },
            set: { newValue in
                let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                guard let minutes = components.minute else { return }
                self.time = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: self.time),
                                                  minute: minutes,
                                                  second: 0,
                                                  of: self.time)!
            }
        )
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 50)
                    .cornerRadius(9)
                
                HStack {
                    Text("\(timeFormatter.string(from: time)) minutes before")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(.chevronDown)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Time",
                    selection: timeBinding,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(height: 50)
                .padding(.horizontal)
            }
            .frame(height: 50)
            .padding(.horizontal)
            .labelsHidden()
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.white)
                .frame(height: 56)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("Poppins-Regular", size: 20))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pop(size: 16, color: Color(red: 169/255, green: 160/255, blue: 163/255))
                .padding(.leading, 30)
                .onTapGesture {
                    isTextFocused = true
                }
                
            }
        }
    }
}

struct EventOnToday: View {
    let event: EventModel
    
    private var timeComponentsFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var currentTime: String {
        timeComponentsFormatter.string(from: event.time)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 230 / 255, green: 236 / 255, blue: 243 / 255))
                .frame(height: 84)
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        if event.color != "4" {
                            Circle()
                                .fill(getColor(for: event.color))
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .stroke(Color(red: 200/255, green: 211/255, blue: 222/255), lineWidth: 1)
                                .frame(width: 10, height: 10)
                        }
                        
                        Text("\(currentTime)")
                            .Pop(size: 14)
                    }
                    
                    Text(event.title)
                        .PopBold(size: 14)
                }
                .padding(.horizontal, 35)
                
                Spacer()
            }
        }
        .frame(height: 84)
    }
    
    private func getColor(for colorCode: String) -> Color {
        switch colorCode {
        case "1":
            return Color(red: 236/255, green: 203/255, blue: 153/255)
        case "2":
            return Color(red: 48/255, green: 66/255, blue: 87/255)
        case "3":
            return Color(red: 83/255, green: 109/255, blue: 137/255)
        case "4":
            return Color(.clear)
        default:
            return Color.gray
        }
    }
}

struct NoToday: View {
    var geometry: GeometryProxy
    var action: (() -> ())
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(22)
            
            VStack {
                HStack {
                    Text("Today's Events")
                        .PopBold(size: 18)
                    
                    Spacer()
                    
                    Button(action: {
                        action()
                    }) {
                        Image(.addButton)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
                
                
                Text("There is nothing to do yet!")
                    .Pop(size: 22)
                    .padding(.top, 100)
                Spacer()
            }
        }
        .frame(width: geometry.size.width, height: 463)
    }
}

struct CalendarDayOfWeekCell: View {
    let text: String
    var geometry: GeometryProxy
    var body: some View {
        Text(text)
            .Pop(size: 14)
            .frame(height: geometry.size.width * 0.0945)
    }
}

struct CalendarDayCell: View {
    let text: String
    var isCurrentMonth: Bool = true
    var isToday: Bool = false
    var date: Date
    @ObservedObject var sportCalendarModel: BetCalendarViewModel
    var geometry: GeometryProxy

    var body: some View {
        ZStack {
            Rectangle()
                .fill(isToday ? Color(red: 48/255, green: 66/255, blue: 87/255) : Color(red: 230/255, green: 236/255, blue: 243/255))
                .frame(width: geometry.size.width * 0.0945, height: geometry.size.width * 0.0945)
                .cornerRadius(10)
                .overlay {
                    VStack(spacing: 4) {
                        Text(text)
                            .Pop(size: 14, color: isToday ? .white : (isCurrentMonth
                                                                     ? Color(red: 32/255, green: 41/255, blue: 54/255)
                                                                     : Color(red: 156/255, green: 172/255, blue: 189/255)))

                        HStack(spacing: 2) {
                            let eventsForDate = sportCalendarModel.events.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
                            ForEach(eventsForDate.prefix(3), id: \.id) { event in
                                ZStack {
                                    Circle()
                                        .fill(getColor(for: event.color))
                                        
                                    Circle()
                                        .stroke(.white, lineWidth: 1)
                                }
                                .frame(width: 6, height: 6)
                            }
                        }
                    }
                }
        }
    }

    private func getColor(for colorCode: String) -> Color {
        switch colorCode {
        case "1":
            return Color(red: 236/255, green: 203/255, blue: 153/255)
        case "2":
            return Color(red: 48/255, green: 66/255, blue: 87/255)
        case "3":
            return Color(red: 83/255, green: 109/255, blue: 137/255)
        case "4":
            return Color(.clear)
        default:
            return Color.gray
        }
    }
}
