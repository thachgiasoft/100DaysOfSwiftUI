//
//  PathsVsShapes.swift
//  Drawing
//
//  Created by Jason on 11/9/19.
//  Copyright © 2019 Jason. All rights reserved.
//

/*
 SwiftUI enables custom drawing with two subtly different types: paths and shapes. A path is a series of drawing instructions such as “start here, draw a line to here, then add a circle there”, all using absolute coordinates. In contrast, a shape has no idea where it will be used or how big it will be used, but instead will be asked to draw itself inside a given rectangle.
 
 The key to understanding the difference between Path and Shape is reusability: paths are designed to do one specific thing, whereas shapes have the flexibility of drawing space and can also accept parameters to let us customize them further.
 */

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}

struct PathsVsShapes: View {
    var body: some View {
//        Triangle()
//            .fill(Color.red)
//            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(Color.blue, lineWidth: 10)
        .frame(width: 300, height: 300)
    }
}

struct PathsVsShapes_Previews: PreviewProvider {
    static var previews: some View {
        PathsVsShapes()
    }
}
