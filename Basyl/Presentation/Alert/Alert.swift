//
//  Alert.swift
//  Basyl
//
//  Created by Andrew Kasilov on 31.05.2024.
//

import SwiftUI

struct Alert: View {
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    presentAlert.toggle()
                }
            } label: {
                Text("Show Custom Alert")
            }
            
            if presentAlert {
//                Success Alert
                
                CustomAlert(presentAlert: $presentAlert) {
                    withAnimation {
                        presentAlert.toggle()
                    }
                } rightButtonAction: {
                    withAnimation {
                        presentAlert.toggle()
                    }
                }

//                Error Alert
                
//                CustomAlert(presentAlert: $presentAlert, alertType: .error(title: "Error", message: "Please confirm that you're still open to session requests then you will find the call from new user."), isShowVerticalButtons: true){
//                    withAnimation{
//                        presentAlert.toggle()
//                    }
//                } rightButtonAction: {
//                    withAnimation{
//                        presentAlert.toggle()
//                    }
//                }
            }
        }
    }

    @State private var presentAlert = false
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        Alert()
    }
}
