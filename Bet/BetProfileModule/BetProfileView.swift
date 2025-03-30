import SwiftUI

struct BetProfileView: View {
    @StateObject var betProfileModel =  BetProfileViewModel()

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
                    Text("Profile")
                        .PopBold(size: 24)
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Spacer(minLength: 20)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "Name") ?? "Name")")
                                        .PopBold(size: 16)
                                    
                                    Text("\(UserDefaultsManager().getEmail() ?? "Name")")
                                        .Pop(size: 14)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    betProfileModel.isEdit = true
                                }) {
                                    Image(.edit)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            Spacer(minLength: 30)
                            
                            Divider()
                            
                            Spacer(minLength: 30)
                            
                            VStack(alignment: .leading) {
                                Text("Notifications")
                                    .Pop(size: 14)
                                
                                HStack(spacing: 20) {
                                    Image(.notif)
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                    
                                    Text("Push Notifications")
                                        .Pop(size: 14)
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $betProfileModel.isOn)
                                        .toggleStyle(CustomToggleStyle())
                                    
                                }
                            }
                            .padding(.horizontal)
                            
                            Spacer(minLength: 20)
                            
                            Divider()
                            
                            Spacer(minLength: 30)
                            
                            Button(action: {
                                UserDefaultsManager().logout()
                                betProfileModel.isLogOut = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 60)
                                        .padding(.horizontal, 20)
                                        .cornerRadius(12)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.black, lineWidth: 2)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    HStack {
                                        Image(.logout)
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        
                                        Text("Log Out")
                                            .Pop(size: 16)
                                    }
                                }
                            }
                            
                            Spacer(minLength: 20)
                            
                            Button(action: {
                                UserDefaultsManager().deleteAccount()
                                betProfileModel.isLogOut = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 60)
                                        .padding(.horizontal, 20)
                                        .cornerRadius(12)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 236/255, green: 64/255, blue: 30/255), lineWidth: 2)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    HStack {
                                        Image(systemName: "delete.right.fill")
                                            .resizable()
                                            .frame(width: 20, height: 16)
                                            .foregroundStyle(Color(red: 236/255, green: 64/255, blue: 30/255))
                                        
                                        Text("Delete Account")
                                            .Pop(size: 16, color: Color(red: 236/255, green: 64/255, blue: 30/255))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 5)
                }
            }
            .fullScreenCover(isPresented: $betProfileModel.isEdit) {
                BetEditView()
            }
            
            .fullScreenCover(isPresented: $betProfileModel.isLogOut) {
                BetSignInView()
            }
        }
    }
}

#Preview {
    BetProfileView()
}

