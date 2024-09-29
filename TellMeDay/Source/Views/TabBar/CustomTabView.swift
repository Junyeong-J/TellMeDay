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
    @State private var hideTabBar: Bool = false
    private let repository = ListTableRepository()
    @State var firstNaviLinkActive = false
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selected) {
                Group {
                    NavigationView {
                        MainView(hideTabBar: $hideTabBar)
                            .onAppear { hideTabBar = false }
                        Spacer()
                    }
                    .tag(Tab.calendar)
                    
                    NavigationView {
                        AnalyzeView()
                        Spacer()
                    }
                    .tag(Tab.chart)
                    
                    NavigationView {
                        MyDiaryView()
                        Spacer()
                    }
                    .tag(Tab.myRecode)
                    
                    NavigationView {
                        SettingsView()
                    }
                    .tag(Tab.settings)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            if !hideTabBar {
                VStack {
                    Spacer()
                    tabBar
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
    
    var tabBar: some View {
        
        HStack {
            Spacer()
            tabButton(for: .calendar, iconName: .calendar)
            Spacer()
            tabButton(for: .chart, iconName: .chart)
            Spacer()
//            Spacer()
            tabButton(for: .myRecode, iconName: .myRecode)
            Spacer()
//            Spacer()
//            tabButton(for: .settings, iconName: .settings)
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background {
            Rectangle()
                .fill(.appTabBar)
                .shadow(color: .black.opacity(0.2), radius: 8, y: 2)
                .edgesIgnoringSafeArea(.all)
        }

    }
    
    @ViewBuilder
    private func tabButton(for tab: Tab, iconName: IconImageName) -> some View {
        Button {
            selected = tab
            hideTabBar = false
        } label: {
            Image(systemName: iconName.rawValue)
                .tabIconView(isSelected: selected == tab, systemName: iconName.rawValue)
        }
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
