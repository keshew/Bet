import SwiftUI

struct BetEditView: View {
    @StateObject var betEditModel =  BetEditViewModel()
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
                        
                        Text("Edit name")
                            .PopBold(size: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: geometry.size.width,
                                   height: 0.3)
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("Name")
                                    .Pop(size: 14)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            CustomTextFiled(text: $betEditModel.name,
                                            geometry: geometry,
                                            placeholder: "\(betEditModel.name)")
                        }
                        
                        Spacer(minLength: 500)
                        
                        Button(action: {
                            if betEditModel.saveChanges() {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Rectangle()
                                .fill(Color(red: 48/255, green: 66/255, blue: 87/255))
                                .frame(height: 56)
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                                .overlay {
                                    Text("Save")
                                        .Pop(size: 16, color: .white)
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BetEditView()
}

