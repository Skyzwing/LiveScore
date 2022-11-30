//
//  ContentView.swift
//  LiveScore
//
//  Created by oat.surachet on 24/11/2565 BE.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var currentActivity: Activity<FootballMatch>? = nil
    var body: some View {
        VStack {
            Button("Start Activity") {
                startActivity()
            }.padding(.bottom)
            
            Button("Update Activity") {
                updateActivity()
            }.padding(.bottom)
            
            Button("Stop Activity") {
                stopActivity()
            }
        }
        .padding()
    }
    
    
    private func startActivity() {
        let attributes = FootballMatch(fullNameFirstTeam: "THAILAND", shortNameFirstTeam: "THAI", firstTeamLogo: "Thailand", fullNameSecondTeam: "JAPAN", shortNameSecondTeam: "JAP", secondTeamLogo: "Japan")
        let contentState = FootballMatch.ContentState(score1: 0, score2: 0, information: "")
        do {
            currentActivity = try Activity<FootballMatch>.request(attributes: attributes, contentState: contentState)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateActivity() {
        let contentState = FootballMatch.ContentState(score1: 1, score2: 0, information: "Surasak get goal!!")

        Task {
            await currentActivity?.update(using: contentState)
        }
    }
    
    private func stopActivity() {
        let state = FootballMatch.ContentState(score1: 0, score2: 0, information: "Somsak got hat-trick!!")
        
        Task {
            await currentActivity?.end(using: state, dismissalPolicy: .default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
