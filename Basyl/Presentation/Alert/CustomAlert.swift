//
//  CustomAlert.swift
//  Basyl
//
//  Created by Andrew Kasilov on 03.06.2024.
//

import SwiftUI

/// Alert type
enum AlertType {
    
    case success
    case error(title: String, message: String = "")
    
    func title() -> String {
        switch self {
        case .success:
            return "Clear App"
        case .error(title: let title, _):
            return title
        }
    }

    func message() -> String {
        switch self {
        case .success:
            return "Do you really want to clear the app? All created avatars will be lost."
        case .error(_, message: let message):
            return message
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .success:
            return "Clear"
        case .error(_, _):
            return "Go"
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .success:
            return "Cancel"
        case .error(_, _):
            return "Cancel"
        }
    }
    
    func height(isShowVerticalButtons: Bool = false) -> CGFloat {
        switch self {
        case .success:
            return isShowVerticalButtons ? 220 : 150
        case .error(_, _):
            return isShowVerticalButtons ? 220 : 150
        }
    }
}

/// A boolean State variable is required in order to present the view.
struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .success
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                
                if alertType.title() != "" {
                    
                    // alert title
                    Text(alertType.title())
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                // alert message
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                if !isShowVerticalButtons {
                    HStack(spacing: 0) {
                        
                        // left button
                        if (!alertType.leftActionText.isEmpty) {
                            Button {
                                leftButtonAction?()
                            } label: {
                                Text(alertType.leftActionText)
                                    .font(.system(size: 17))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Divider()
                                .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                        }
                        
                        // right button (default)
                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                    .padding([.horizontal, .bottom], 0)
                    
                } else {
                    VStack(spacing: 0) {
                        Spacer()
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                        
                        Divider()
                        
                        Spacer()
                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Spacer()
                        
                    }
                    .frame(height: verticalButtonsHeight)
                }
                
            }
//            .frame(width: 270, height: alertType.height(isShowVerticalButtons: isShowVerticalButtons))
            .frame(width: 270, height: 138)
            .background(
                Color.gray
            )
            .cornerRadius(14)
        }
        .zIndex(2)
    }
}

