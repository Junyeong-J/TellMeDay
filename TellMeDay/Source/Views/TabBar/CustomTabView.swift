//
//  CustomTabView.swift
//  TellMeDay
//
//  Created by 전준영 on 9/20/24.
//

import SwiftUI

struct CustomTabView: View {
    enum Tab {
        case calendar, chart, myRecode, settings
    }
    
    @State private var selected: Tab = .calendar
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selected) {
                Group {
                    NavigationStack {
                        MainView()
                    }
                    .tag(Tab.calendar)
                    
                    NavigationStack {
                        RecodeView(selectedDate: Date())
                    }
                    .tag(Tab.chart)
                    
                    NavigationStack {
                        RecodeView(selectedDate: Date())
                    }
                    .tag(Tab.myRecode)
                    
                    NavigationStack {
                        SettingsView()
                    }
                    .tag(Tab.settings)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            VStack {
                Spacer()
                tabBar
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    var tabBar: some View {
        HStack {
            tabButton(for: .calendar, iconName: .calendar)
            Spacer()
            tabButton(for: .chart, iconName: .chart)
            Spacer()
            Spacer()
            tabButton(for: .myRecode, iconName: .myRecode)
            Spacer()
            tabButton(for: .settings, iconName: .settings)
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background {
            CustomTabBarShape()
                .fill(.appTabBar)
                .shadow(color: .black.opacity(0.2), radius: 8, y: 2)
                .edgesIgnoringSafeArea(.all)
        }
        
        .overlay(
            CircleButtonView()
                .offset(y: -50)
        )
    }
    
    @ViewBuilder
    private func tabButton(for tab: Tab, iconName: IconImageName) -> some View {
        Button {
            selected = tab
        } label: {
            Image(systemName: iconName.rawValue)
                .tabIconView(isSelected: selected == tab, systemName: iconName.rawValue)
        }
    }
    
}

struct CircleButtonView: View {
    var body: some View {
        Button(action: {
            
        }) {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.appMain)
        }
        
        .background(
            Circle()
                .fill(Color.white)
                .shadow(color: .appMain.opacity(0.15), radius: 8, y: 2)
        )
    }
}

struct CustomTabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.35, y: 0))
        path.addArc(center: CGPoint(x: rect.width * 0.5, y: 0),
                    radius: 35,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.width * 0.65, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
            .font(.largeTitle)
            .padding()
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
