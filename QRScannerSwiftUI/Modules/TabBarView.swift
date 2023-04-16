//
//  TabBarView.swift
//  QRScannerSwiftUI
//
//  Created by Cenk Bahadır Çark on 2.04.2023.
//
import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            QRCodeScannerView()
                .tabItem {
                    Image(systemName: "scanner")
                    Text("Scanner")
                        .font(.title)
                }
            QRCodeGeneratorView()
                .tabItem {
                    Image(systemName: "pencil.line")
                    Text("Generator")
                        .font(.title)
                }
        }
        .onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                //83 120 149
                appearance.backgroundColor = UIColor(displayP3Red: 9/255, green: 32/255, blue: 63/255, alpha: 0.9)
                //appearance.backgroundColor = UIColor(displayP3Red: 9/255, green: 32/255, blue: 63/255, alpha: 1.0)
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .accentColor(.white)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
