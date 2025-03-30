import SwiftUI

struct BetCalendarView: View {
    @StateObject var betCalendarModel = BetCalendarViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Color.white
                        .ignoresSafeArea()
                        .frame(height: geometry.size.height * 0.0386)
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.00064)
                        .opacity(0.5)
                        .offset(y: geometry.size.height * 0.0103)
                    
                    Color(red: 230/255, green: 236/255, blue: 243/255)
                        .ignoresSafeArea()
                    
                    Color(red: 230/255, green: 236/255, blue: 243/255)
                        .ignoresSafeArea()
                    
                    Color.white
                        .ignoresSafeArea()
                }
                
                VStack {
                    Text("Calendar")
                        .PopBold(size: 24)
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Spacer(minLength: geometry.size.height * 0.0129)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 230/255, green: 236/255, blue: 243/255))
                                
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(betCalendarModel.currentMonth + " " + betCalendarModel.currentYear)
                                                .PopBold(size: 18)
                                            
                                            Text(betCalendarModel.formattedToday)
                                                .Pop(size: 14)
                                        }
                                        .padding(.leading, geometry.size.width * 0.05)
                                        
                                        Spacer()
                                        
                                        Button(action: betCalendarModel.previousMonth) {
                                            Image(.chevronLeft)
                                                .resizable()
                                                .frame(width: geometry.size.height * 0.0116,
                                                       height: geometry.size.height * 0.0206)
                                        }
                                        .padding(.trailing)
                                        
                                        Button(action: betCalendarModel.nextMonth) {
                                            Image(.chevronRight)
                                                .resizable()
                                                .frame(width: geometry.size.height * 0.0116,
                                                       height: geometry.size.height * 0.0206)
                                        }
                                        .padding(.trailing)
                                    }
                                    .padding(.top)
                                    
                                    HStack(spacing: geometry.size.width * 0.07) {
                                        ForEach(0..<7, id: \.self) { i in
                                            CalendarDayOfWeekCell(text: betCalendarModel.daysOfWeek[i], geometry: geometry)
                                        }
                                    }
                                    
                                    LazyVGrid(columns: betCalendarModel.grid) {
                                        ForEach(betCalendarModel.dates.indices, id: \.self) { i in
                                            let date = betCalendarModel.dates[i]
                                            let isCurrentMonth = Calendar.current.isDate(date, equalTo: betCalendarModel.currentDate, toGranularity: .month)
                                            let isToday = betCalendarModel.isToday(date: date)
                                            
                                            CalendarDayCell(
                                                text: "\(Calendar.current.component(.day, from: date))",
                                                isCurrentMonth: isCurrentMonth,
                                                isToday: isToday,
                                                date: date,
                                                sportCalendarModel: betCalendarModel, geometry: geometry
                                            )
                                        }
                                    }
                                    .padding(.bottom)
                                }
                            }
//                            .frame(width: geometry.size.width,
//                                   height: geometry.size.height * 0.437)
                            
                            if betCalendarModel.events2.isEmpty {
                                NoToday(geometry: geometry, action: {
                                    betCalendarModel.isAdd = true
                                })
                            } else {
                                ZStack {
                                    Rectangle()
                                        .fill(.white)
                                        .cornerRadius(geometry.size.height * 0.0283)
                                    
                                    VStack {
                                        HStack {
                                            Text("Today's Events")
                                                .PopBold(size: 18)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                betCalendarModel.isAdd = true
                                            }) {
                                                Image(.addButton)
                                                    .resizable()
                                                    .frame(width: geometry.size.height * 0.0513,
                                                           height: geometry.size.height * 0.0513)
                                            }
                                        }
                                        .padding(.horizontal, geometry.size.width * 0.05)
                                        .padding(.top)
                                        
                                        ForEach(betCalendarModel.events2) { event in
                                            EventOnToday(event: event)
                                                .padding(.top, geometry.size.height * 0.0064)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: geometry.size.width)
                            }
                            
                            Color(.clear)
                                .frame(height: geometry.size.height * 0.077)
                        }
                    }
                    .padding(.top, geometry.size.height * 0.0064)
                }
            }
            .fullScreenCover(isPresented: $betCalendarModel.isAdd) {
                BetAddEventView()
            }
            
            .onChange(of: betCalendarModel.isAdd) { _ in
                betCalendarModel.loadEvents()
                betCalendarModel.loadEvents2()
            }
        }
    }
}

#Preview {
    BetCalendarView()
}
