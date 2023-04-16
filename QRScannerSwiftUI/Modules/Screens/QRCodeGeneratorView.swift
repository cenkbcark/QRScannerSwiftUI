//
//  QRCodeGeneratorView.swift
//  QRScannerSwiftUI
//
//  Created by Cenk Bahadır Çark on 2.04.2023.
//

import SwiftUI

struct QRCodeGeneratorView: View {
    
    @State var generateQR: String = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea(.all)
            VStack {
                Text("Please enter a valid value to generate a a QR Code.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.title)
                    .font(.custom("Marker Felt", size: 22))
                    .foregroundColor(.white)
                TextField("Please enter your value", text: $generateQR).extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .white)
                .padding()
                .multilineTextAlignment(.center)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                if generateQR != "" {
                    VStack(spacing: 25) {
                        Image(uiImage: UIImage(data: returnData(str: self.generateQR) ?? Data()) ?? UIImage()).resizable().frame(width: 200, height: 200)
                        Button {
                            shareData(data: returnData(str: self.generateQR) ?? Data())
                        } label: {
                            Text("Share your QR Code")
                            
                        }
                    }
                }else {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                }
            }
        }
        .onTapGesture {
            dissmisKeyboard()
        }
    }
    func returnData(str: String) -> Data? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let data = str.data(using: .ascii, allowLossyConversion: false)
        filter?.setValue(data, forKey: "inputMessage")
        let image = filter?.outputImage
        let uiimage = UIImage(ciImage: image ?? CIImage())
        return uiimage.pngData()
    }
    func shareData(data: Data?) {
        guard let data = data else { return }
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
    }
}

struct QRCodeGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeGeneratorView()
    }
}


extension View {
    func dissmisKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension TextField {

    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color,  endColor: Color) -> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .shadow(color: .white, radius: 10)
    }
}
