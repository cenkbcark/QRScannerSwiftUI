//
//  QRCodeScannerView.swift
//  QRScannerSwiftUI
//
//  Created by Cenk Bahadır Çark on 2.04.2023.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    
    @State var isPresentingScanner = false
    @State var scannedCode = ""
    @State var hasError = false
    private let pastboard = UIPasteboard.general
    
    var scannerSheet : some View {
        CodeScannerView(codeTypes: [.qr]) { result in
            if case let .success(code) = result {
                self.scannedCode = code.string
                self.isPresentingScanner = false
            }
            if case let .failure(failure) = result {
                print(failure.localizedDescription)
            }
        }
    }
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                Button {
                    self.isPresentingScanner = true
                } label: {
                    Text("Scan QR Code")
                        .frame(width: 280, height: 30)
                        .padding()
                        .foregroundColor(.white)
                        .font(.title)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(12)
                    
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                Text(scannedCode)
                    .bold()
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                Spacer()
                if scannedCode != "" {
                    let verifyURL = verifyUrl(urlString: scannedCode)
                    if verifyURL {
                        Link(destination: URL(string: "\(scannedCode)")!, label: {
                            Text("Go To Link")
                                .bold()
                                .frame(width: 280, height: 50)
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(12)
                        })
                        .padding(.bottom, 50)
                    }else {
                        Button {
                            pastboard.string = scannedCode
                        } label: {
                            Text("Copy the clipboard")
                                .frame(width: 280, height: 30)
                                .padding()
                                .foregroundColor(.white)
                                .font(.title)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(12)
                        }
                        Text("This url can not be open.")
                            .bold()
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .padding(.bottom, 50)
                    }
                }
            }
        }
    }
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
