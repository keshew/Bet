import SwiftUI

struct BetOnboardingView: View {
    @StateObject var betOnboardingModel =  BetOnboardingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 230/255, green: 236/255, blue: 243/255)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("\(betOnboardingModel.currentIndex + 1)/3")
                                .Pop(size: 16)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    betOnboardingModel.isMenu = true
                                }
                            }) {
                                Text("Skip")
                                    .Pop(size: 16)
                                    .padding(.trailing)
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        Image(betOnboardingModel.contact.arrayImage[betOnboardingModel.currentIndex])
                            .resizable()
                            .frame(
                                width: betOnboardingModel.currentIndex == 2
                                    ? geometry.size.width
                                    : geometry.size.width * 0.59,
                                height: geometry.size.height * 0.553
                            )
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(betOnboardingModel.contact.arrayOfLabel[betOnboardingModel.currentIndex])
                                    .PopBold(size: 24)
                                    .frame(height: 30)
                                
                                Text(betOnboardingModel.contact.arrayOfText[betOnboardingModel.currentIndex])
                                       .Pop(size: 20)
                                       .frame(height: 120, alignment: .top)
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        Button(action: {
                            if betOnboardingModel.currentIndex < 2 {
                                withAnimation {
                                    betOnboardingModel.currentIndex += 1
                                }
                            } else {
                                betOnboardingModel.isMenu = true
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                    .frame(height: 56)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                
                                HStack {
                                    Spacer()
                                    
                                    Text("Next")
                                        .Pop(size: 16, color: .white)
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                    
                                    Image(.arrowNext)
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                        .padding(.trailing)
                                }
                                .padding(.horizontal, 15)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $betOnboardingModel.isMenu) {
                BetTabBarView()
            }
        }
    }
}

#Preview {
    BetOnboardingView()
}

