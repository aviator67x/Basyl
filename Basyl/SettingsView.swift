//
//  SwiftUIView.swift
//  Basyl
//
//  Created by Andrew Kasilov on 15.05.2024.
//

import SwiftUI

enum SelectedItem {
    case notifications
    case clear
    case rate
    case submit
    case invite
    case privacy
    case terms
    case gallery
    case settings
    case btncreate
}

protocol SettingsViewDelegate: AnyObject {
    func itemDidTap(_ item: SelectedItem)
}

struct SettingsView: View {
    @State private var appVersion: String = "1.0.0"
    
    weak var delegate: SettingsViewDelegate?

    var body: some View {
        GeometryReader { geometry in
            let multiplier = geometry.size.width / 390
            VStack(alignment: .leading) {
                headerView(multiplier: multiplier)
                ScrollView {
                    general(multiplier: multiplier)
                    other(multiplier: multiplier)
                    security(multiplier: multiplier)
                }
                    
                Spacer(minLength: 50 * multiplier)
                    
                tabView(multiplier: multiplier)
            }
            .background(Color.black)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

private extension SettingsView {
    @ViewBuilder
    func headerView(multiplier: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0)  {
            Text("Version App \(appVersion)")
                .font(.system(size: 18))
                .foregroundColor(Color("settingsHeader"))
                .padding(.bottom, 8)
                .padding(.top, 16)
            
            Text("Settings App")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    func general(multiplier: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0)  {
            Text("General")
                .font(.system(size: 16))
                .foregroundColor(Color("settingsTitle"))
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                row(leftImage: "iconNofications", text: "Notifications", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.notifications)
                    }
                
                Color.black
                    .frame(height: 1)
                
                row(leftImage: "iconBin", text: "Clear App", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.clear)
                    }
            }
            .background(Color("listBackground"))
            .cornerRadius(28 * multiplier)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    func other(multiplier: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0)  {
            Text("Other")
                .font(.system(size: 16))
                .foregroundColor(Color("settingsTitle"))
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                row(leftImage: "iconRate", text: "Rate Us", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.rate)
                    }
                
                Color.black
                    .frame(height: 1)
                
                row(leftImage: "iconFeedback", text: "Submit Feedback", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.submit)
                    }
                
                Color.black
                    .frame(height: 1)
                
                row(leftImage: "iconShare", text: "Invite Friends", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.invite)
                    }
            }
            .background(Color("listBackground"))
            .cornerRadius(28 * multiplier)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    func security(multiplier: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Security & Policy")
                .font(.system(size: 16))
                .foregroundColor(Color("settingsTitle"))
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                row(leftImage: "iconPrivacy", text: "Privacy Policy", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.privacy)
                    }
                
                Color.black
                    .frame(height: 1)
                
                row(leftImage: "iconTerms", text: "Terms and Conditions", multiplier: multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.terms)
                    }
            }
            .background(Color("listBackground"))
            .cornerRadius(28 * multiplier)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func row(leftImage: String, text: String, multiplier: CGFloat) -> some View {
        HStack {
            Image(leftImage)
                .resizable()
                .frame(width: 24 * multiplier, height: 24 * multiplier)
            
            Text(text)
                .foregroundColor(.white)
            
            Spacer()
            
            Image("iconChevronRight")
//                .resizable()
                .frame(width: 24 * multiplier, height: 24 * multiplier)
        }
        .padding(8)
        .padding(.bottom, 0)
    }
    
    @ViewBuilder
    func tabView(multiplier: CGFloat) -> some View {
        ZStack {
            TabBarShape(multiplier: multiplier, corner: 50, buttonRadius: 50, distance: 5, offsetVertical: 10)
                .frame(height: 100 * multiplier)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.cyan) // (Color("listBackground"))
            
            HStack {
                Image("iconGallery")
                    .resizable()
                    .frame(width: 32 * multiplier, height: 32 * multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.gallery)
                    }
                
                Spacer()
                
                Image("iconSettings")
                    .resizable()
                    .frame(width: 32 * multiplier, height: 32 * multiplier)
                    .onTapGesture {
                        self.delegate?.itemDidTap(.settings)
                    }
            }
            .padding(.horizontal, 50)
            .offset(y: -10 * multiplier)

            Image("btnCreate")
                .resizable()
                .frame(width: 100 * multiplier, height: 100 * multiplier)
                .offset(y: -50 * multiplier)
                .onTapGesture {
                    self.delegate?.itemDidTap(.btncreate)
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
