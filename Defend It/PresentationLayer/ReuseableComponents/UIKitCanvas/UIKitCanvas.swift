//
//  UIKitCanvas.swift
//  Defend It
//
//  Created by Роман Сенкевич on 16.08.22.
//

import Foundation
import SwiftUI

struct UIKitCanvas: PreviewProvider {
    static var previews: some View {
        UIViewControllerCanvas().edgesIgnoringSafeArea(.all)
    }
    
    struct UIViewCanvas: UIViewRepresentable {
        
        func makeUIView(context: Context) -> some UIView {
            return HomePageView(frame: CGRect.zero)
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
    
    struct UIViewControllerCanvas: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return FlowTabbarController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
