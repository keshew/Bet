import SwiftUI

struct BetTabBarView: View {
    @StateObject var betTabBarModel =  BetTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Calendar
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Calendar {
                    BetCalendarView()
                } else if selectedTab == .Tasks {
                    BetTasksView()
                } else if selectedTab == .Profile {
                    BetProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BetTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Calendar
        case Tasks
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if selectedTab == TabType.Calendar {
                Color(.white)
                    .frame(height: 100)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 35)
                    .overlay(
                           Rectangle()
                            .fill(Color(red: 239/255, green: 240/255, blue: 244/225))
                            .frame(height: 1)
                            .offset(y: -15)
                       )
            } else {
                Color(red: 230/255, green: 236/255, blue: 243/255)
                    .frame(height: 100)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 35)
                    .overlay(
                           Rectangle()
                            .fill(Color(red: 239/255, green: 240/255, blue: 244/225))
                            .frame(height: 1)
                            .offset(y: -15)
                       )
            }
           
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Calendar, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Tasks, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 5)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                Text("\(tab)")
                    .Pop(size: 12, color: selectedTab == tab ? Color(red: 48/255, green: 66/255, blue: 87/255) : Color(red: 169/255, green: 182/255, blue: 195/255))
            }
            .frame(maxWidth: .infinity)
        }
    }
}
