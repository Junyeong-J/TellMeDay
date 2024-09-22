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
        }
    }
    
    var tabBar: some View {
        HStack {
            Spacer()
            Button {
                selected = .calendar
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .calendar {
                        Text("Calendar")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .calendar ? Color.accentColor : Color.primary)
            Spacer()
            Button {
                selected = .chart
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "chart.bar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .chart {
                        Text("Chart")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .chart ? Color.accentColor : Color.primary)
            Spacer()
            
            Button {
                selected = .myRecode
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .myRecode {
                        Text("Records")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .myRecode ? Color.accentColor : Color.primary)
            
            Spacer()
            Button {
                selected = .settings
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .settings {
                        Text("Settings")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .settings ? Color.accentColor : Color.primary)
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 72)
        .background {
            CustomTabBarShape()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .overlay(
            CircleButtonView()
                .offset(y: -30)
        )
    }
}

struct CircleButtonView: View {
    var body: some View {
        Button(action: {
            // 글쓰기 버튼의 액션 처리
        }) {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
        }
        .background(
            Circle()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        )
    }
}

struct CustomTabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 왼쪽 직선
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.4, y: 0))
        
        // 곡선 (글쓰기 버튼 공간)
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.6, y: 0),
                          control: CGPoint(x: rect.width * 0.5, y: 50))
        
        // 오른쪽 직선
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
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
