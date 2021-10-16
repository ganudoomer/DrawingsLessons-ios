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


struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for number in stride(from: 0,to: CGFloat.pi * 2,by: CGFloat.pi/8){
            let rotation = CGAffineTransform(rotationAngle: number)
            
    
            let postion = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let originalPetal = Path(ellipseIn:CGRect(x:CGFloat(petalOffset),y:0,width: CGFloat(petalWidth),height:rect.width/2))
            let roatedPetal = originalPetal.applying(postion)
            
            path.addPath(roatedPetal)
        }
        return path
    }
}


// Making a flower
struct  ContentViewNew: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth  = 100.0
    var body: some View {
        VStack{
            Flower(petalOffset: Double(petalOffset), petalWidth: petalWidth).fill(Color.red,style: FillStyle(eoFill:true))

            Text("Offset")
            Slider(value: $petalOffset,in:-40...40).padding([.horizontal,.bottom])
            
            Text("Width")
            Slider(value: $petalWidth,in: -40...40).padding([.horizontal,.bottom])
            
            
        }
    }
}


 // Border images
// Image Paint

struct Lesson2 : View {
    var body: some View {
        Capsule().strokeBorder(ImagePaint(image: Image("Example"),scale: 0.1), lineWidth: 20).frame(width: 300, height: 200)
        
        Text("Hello World").frame(width: 300, height: 300).border(ImagePaint(image: Image("Example"),sourceRect:CGRect(x:0,y:0.25, width: 1.0,height:0.5),scale: 0.1),width: 30)
    }
}


struct ColorCycleCricle: View {
    var amount = 0.0
    var steps = 100
    var body: some View {
        ZStack{
            ForEach(0..<steps){value in
                Rectangle().inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom),lineWidth:2)
            }
            // Add when Metal GPU
        }.drawingGroup()
    }
    
    func color(for value:Int,brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue:targetHue,saturation: 1,brightness: brightness)
    }


}


struct Lesson3 : View {
    @State private var colorCycle = 0.0
    var body: some View {
        VStack{
            ColorCycleCricle(amount: self.colorCycle).frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Lesson3()
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
