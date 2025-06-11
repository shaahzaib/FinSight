//
//  GraphView.swift
//  FinSight
//
//  Created by Macbook Pro on 31/05/2025.
//

import SwiftUI

struct GraphView: View {
    
    var data : [CGFloat]
    @State var currentPlot = ""
    @State var offset : CGSize = .zero
    @State var showPlot:Bool = false
    @State var translation:CGFloat = 0
    var body: some View {
        GeometryReader{proxy in
            
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count-1)
            
            let maxPoint = (data.max() ?? 0) + 100
            
            // defining points for the graph
            let points = data.enumerated().compactMap{item ->
                CGPoint in
                
                let progress = item.element / maxPoint
                
                let pathHeight = progress * height
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            
            ZStack{
                
                // plopting points
                
                // path
                Path{path in
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    
                    path.addLines(points)
                    
                    
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5,lineCap: .round,lineJoin: .round))
                .fill(
                    LinearGradient(colors: [Color(.purple),Color(.orange)], startPoint: .leading, endPoint: .trailing)
                    
                )
                
                bgfilling()
                
                    .clipShape(
                        Path{path in
                            
                            path.move(to: CGPoint(x: 0, y: 0))
                           
                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x:0, y: height))
                            
                        }
                        
                    )
                
                
                
            }
            .overlay(
                
                // indicator dragging
                VStack(spacing: 0){
                    
                    Text(currentPlot)
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,10)
                        .background(.purple, in: Capsule())
                        .offset(x: translation < 10 ? 30 : 0)
                        .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                    
                    Rectangle()
                        .fill(Color(.purple))
                        .frame(width: 1,height: 40)
                        .padding(.top )
                    
                    Circle()
                        .fill(Color(.purple))
                        .frame(width: 22,height: 22)
                        .overlay (
                            Circle()  .fill(.white)
                            .frame(width: 10, height: 10)
                        )
                    
                    
                    Rectangle()
                        .fill(Color(.purple))
                        .frame(width: 1,height: 50 )
                       
                }
                    .frame(width: 80, height: 170)
                    .offset(y: 70)
                    .offset(offset),
                alignment: .bottomLeading
                
            ).contentShape(Rectangle())
                .gesture(DragGesture().onChanged({value in
                    
                    withAnimation{showPlot = true}
                    
                    let translation = value.location.x
                    
                    let index = max(min(Int((translation / width).rounded()+1 ),data.count-1),0)
                    
                    currentPlot = "$\(data[index])"
                    
                    self.translation = translation
                    
                    // removing half width to place indicator on graph line
                    offset = CGSize(width:points[index].x - 40,
                                    height: points[index].y - height)
                    
                }).onEnded({value in
                    withAnimation{showPlot = false}
                    
                })
                )
            
            
            
        }
        .overlay(
            VStack(alignment: .leading){
               
                let max = data.max() ?? 0
                
                Text("$ \(Int(max))")
                    .font(.caption.bold())
                
                Spacer()
                
                Text("$ 0")
                    .font(.caption.bold())
                
            }
                .frame(maxWidth: .infinity,alignment: .leading)
            
        )
        .padding(.horizontal,10)
        
        
        
    }
    @ViewBuilder
    func bgfilling()-> some View{
        LinearGradient(colors: [Color(.orange).opacity(0.3),
                                Color(.orange).opacity(0.2),
                                Color(.orange).opacity(0.1)] + Array(repeating:
                                        Color(.purple).opacity(0.1)         , count: 4) + Array(repeating:
                                                                                                    Color.clear, count: 2)
                       
                       , startPoint: .top, endPoint: .bottom)
    }
}

#Preview {
    ContentView()
}
