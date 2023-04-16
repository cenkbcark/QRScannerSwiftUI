//
//  Onboarding.swift
//  QRScannerSwiftUI
//
//  Created by Cenk Bahadır Çark on 2.04.2023.
//

import SwiftUI
import Lottie

struct Onboarding: View {
    var body: some View {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("color1"), Color("color2")]), startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(.all)
                    VStack {
                        LottieView(lottieFile: "QRAnimation")
                            .frame(width: 300, height: 300)
                        VStack{
                            Spacer()
                            Text("You can easily scan your QR codes or create yours.")
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .font(Font.system(size: 22, weight: .semibold, design: .serif))
                                .foregroundColor(.white)
                            Spacer()
                            NavigationLink {
                                TabBarView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Text("Lets Get Started")
                                    .bold()
                                    .frame(width: 280, height: 50)
                                    .foregroundColor(.white)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color("color2"), Color("color1")]), startPoint: .top, endPoint: .bottom)
                                    )
                                    .cornerRadius(12)
                            }

                        }
                        .frame(height: UIScreen.main.bounds.height / 3)
                    }
                }

            }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
