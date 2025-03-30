import SwiftUI

struct BetSignInView: View {
    @StateObject var betSignInModel =  BetSignInViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 230/255, green: 236/255, blue: 243/255)
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Hello!")
                                    .PopBold(size: 24)
                                    .padding(.leading)
                                
                                Text("Sign up to continue organizing\nyour schedule")
                                    .Pop(size: 16)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Name")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betSignInModel.name,
                                                geometry: geometry,
                                                placeholder: "Enter your name")
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Email")
                                        .Pop(size: 14)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                CustomTextFiled(text: $betSignInModel.email,
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
                                CustomSecureFiled(text: $betSignInModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Enter your password")
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            if betSignInModel.register() {
                                betSignInModel.isLog = true
                              } else {
                                  betSignInModel.showErrorAlert = true
                              }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                    .frame(height: 56)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                
                                Text("Sign Up")
                                    .Pop(size: 16, color: .white)
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.296)
                        
                        HStack {
                            Text("Do you have an account?")
                                .Pop(size: 16, color: Color(red: 83/255, green: 109/255, blue: 137/255))
                            
                            Button(action: {
                                betSignInModel.isLog = true
                            }) {
                                Text("Sign In")
                                    .Pop(size: 16)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $betSignInModel.isLog, content: {
                BetLoginView()
            })
            .alert(isPresented: $betSignInModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(betSignInModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    BetSignInView()
}
