//
//  ContentView.swift
//  DrawingsDemo
//
//  Created by Sree on 05/10/21.
//

import SwiftUI

struct Trianle:Shape {
    func path(in rect: CGRect)-> Path {
        var path = Path()
        path.move(to: CGPoint(x:rect.midX,y:rect.minY))
        path.addLine(to:CGPoint(x:rect.minX,y:rect.maxY))
        path.addLine(to:CGPoint(x:rect.maxX,y:rect.maxY))
        path.addLine(to: CGPoint(x:rect.midX,y:rect.minY))
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        let rotationAdj = Angle.degrees(90)
        let modiStart = startAngle - rotationAdj
        let modiEnd = endAngle - rotationAdj
        var path = Path()
        path.addArc(center: CGPoint(x:rect.midX,y:rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modiStart, endAngle: modiEnd, clockwise: clockwise)
        return path
    }

    func inset(by amount:CGFloat)-> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    


}


struct ContentView: View {
    var body: some View {
        Trianle().stroke(Color.red).frame(width: 300, height: 300)
        Arc(startAngle: .degrees(0), endAngle: .degrees(110),
            clockwise: true).frame(width: 300, height: 300)
        Circle().strokeBorder(Color.blue,lineWidth: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct PathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x:200,y:100))
            path.addLine(to:CGPoint(x:100,y:300))
            path.addLine(to:CGPoint(x:300,y:300))
            path.addLine(to: CGPoint(x:200,y:100))
          
        }.stroke(Color.blue,style: StrokeStyle(lineWidth: 10, lineCap: .round))
    }
    
}
