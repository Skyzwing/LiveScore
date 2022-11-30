//
//  LiveScoreWidgetBundle.swift
//  LiveScoreWidget
//
//  Created by oat.surachet on 24/11/2565 BE.
//

import WidgetKit
import SwiftUI

@main
struct LiveScoreWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveScoreWidget()
        LiveScoreWidgetLiveActivity()
    }
}
