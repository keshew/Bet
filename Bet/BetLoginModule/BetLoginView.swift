import SwiftUI

struct BetLoginView: View {
    @StateObject var betLoginModel =  BetLoginViewModel()
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
                                Image(.back)
                                    .resizable()
                                    .frame(width: 15, height: 18)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Welcome Back")
                                    .PopBold(size: 24)
                                    .padding(.leading)
                                
                                Text("Sign in to continue organizing your\nschedule")
                                    .Pop(size: 16)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Email")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betLoginModel.email,
                                                geometry: geometry,
                                                placeholder: "Enter your email")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Password")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomSecureFiled(text: $betLoginModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Enter your password")
                            }
                        }
                        
                        Spacer(minLength: 25)
                        
                        Button(action: {
                            if betLoginModel.login() {
                                if UserDefaultsManager().isFirstLaunch() {
                                    betLoginModel.isOnb = true
                                } else {
                                    betLoginModel.isTab = true
                                }
                            } else {
                                if betLoginModel.email != "", betLoginModel.password != "" {
                                    betLoginModel.alertMessage = "Incorrect email or password"
                                    betLoginModel.showErrorAlert = true
                                } else {
                                    betLoginModel.showErrorAlert = true
                                }
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                    .frame(height: 56)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                
                                Text("Log in")
                                    .Pop(size: 16, color: .white)
                            }
                        }
                        
                        Button(action: {
                            UserDefaultsManager().enterAsGuest()
                            if UserDefaultsManager().isFirstLaunch() {
                                betLoginModel.isOnb = true
                            } else {
                                betLoginModel.isTab = true
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 212/255, green: 221/255, blue: 231/255))
                                    .frame(height: 56)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                
                                Text("Continue as a guest")
                                    .Pop(size: 16)
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.36)
                        
                        HStack {
                            Text("Don't have an account?")
                                .Pop(size: 16, color: Color(red: 83/255, green: 109/255, blue: 137/255))
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Sign Up")
                                    .Pop(size: 16)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(isPresented: $betLoginModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(betLoginModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .fullScreenCover(isPresented: $betLoginModel.isOnb) {
                BetOnboardingView()
            }
            .fullScreenCover(isPresented: $betLoginModel.isTab) {
                BetTabBarView()
            }
        }
    }
}

#Preview {
    BetLoginView()
}

