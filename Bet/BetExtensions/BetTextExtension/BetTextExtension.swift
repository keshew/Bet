import SwiftUI

extension Text {
    func Pop(size: CGFloat,
                 color: Color = Color(red: 48/255, green: 66/255, blue: 87/255)) -> some View {
        self.font(.custom("Poppins-Regular", size: size))
            .foregroundColor(color)
    }
    
    func PopBold(size: CGFloat,
                 color: Color = Color(red: 48/255, green: 66/255, blue: 87/255)) -> some View {
        self.font(.custom("Poppins-Bold", size: size))
            .foregroundColor(color)
    }
}
