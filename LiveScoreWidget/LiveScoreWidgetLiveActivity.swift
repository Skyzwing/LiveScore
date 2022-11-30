//
//  LiveScoreWidgetLiveActivity.swift
//  LiveScoreWidget
//
//  Created by oat.surachet on 24/11/2565 BE.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct FootballMatch: ActivityAttributes {
    public typealias ContentState = Score
    
    public struct Score: Codable, Hashable {
        let score1: Int
        let score2: Int
        let information: String
    }
    
    let fullNameFirstTeam: String
    let shortNameFirstTeam: String
    let firstTeamLogo: String
    let fullNameSecondTeam: String
    let shortNameSecondTeam: String
    let secondTeamLogo: String
}

struct LiveScoreWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FootballMatch.self) { context in
            // Lock screen/banner UI goes here
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Image(uiImage: UIImage(named: context.attributes.firstTeamLogo)!)
                            .resizable().frame(width: 70, height: 50)
                        Text(context.attributes.shortNameFirstTeam)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Image(uiImage: UIImage(named: context.attributes.secondTeamLogo)!)
                            .resizable().frame(width: 70, height: 50)
                        Text(context.attributes.shortNameSecondTeam)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.information)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text("\(context.state.score1.description) - \(context.state.score2.description)")
                            .font(.largeTitle)
                    }
                }
            } compactLeading: {
                HStack {
                    Text(context.attributes.shortNameFirstTeam)
                    Text(context.state.score1.description)
                }
            } compactTrailing: {
                HStack {
                    Text(context.state.score2.description)
                    Text(context.attributes.shortNameSecondTeam)
                }
            } minimal: {
                Image(systemName: "sportscourt.circle")
                    .foregroundColor(.indigo)
            }
        }
    }
}

private struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<FootballMatch>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Image(uiImage: UIImage(named: context.attributes.firstTeamLogo)!)
                        .resizable()
                        .frame(width: 70, height: 50)
                        .cornerRadius(8)
                    Text(context.attributes.fullNameFirstTeam)
                }
                Spacer()
                VStack {
                    Text("\(context.state.score1.description) - \(context.state.score2.description)")
                        .font(.largeTitle)
                }
                Spacer()
                VStack {
                    Image(uiImage: UIImage(named: context.attributes.secondTeamLogo)!)
                        .resizable()
                        .frame(width: 70, height: 50)
                        .cornerRadius(8)
                    Text(context.attributes.fullNameSecondTeam)
                }
            }
            Divider()
            if context.state.information != "" {
                HStack{
                    Image("ic_information")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(context.state.information)
                        .multilineTextAlignment(.leading)
                        .font(.body.bold())
                        .lineLimit(1)
                }.padding(.bottom, 8)
            }
        }.padding([.leading, .trailing, .top], 8)
    }
}
