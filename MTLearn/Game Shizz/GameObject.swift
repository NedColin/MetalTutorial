//
//  GameObject.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import Foundation
import MetalKit

class GameObject{
    
    var verticesBuf : MTLBuffer?
    var textTureBuf: MTLBuffer?
    
    var lastDisplayTime = CFAbsoluteTimeGetCurrent()
    
    var vertices : [Vertex]!
    
    //animation factor
    var leftx : Float = 0.1          //-0.5 ~  0.5
    var bottomleft : Float = 0.1     //-1.0 ~  0.0
    var bottomright : Float = 0.1    //0.0  ~  1
    var increasing : Float = 0.005
    
    func render(view: MTKView) {
        guard let descripter = view.currentRenderPassDescriptor,
             let drawable = view.currentDrawable else {
             print("error:descripter is nil")
             return
         }
         
         if CFAbsoluteTimeGetCurrent() - lastDisplayTime < 0.001{
             return
         }
         
         let commanderBuffer = Engine.commandQueue.makeCommandBuffer()
         let renderCommanderBufferEncoder = commanderBuffer?.makeRenderCommandEncoder(descriptor: descripter)
         renderCommanderBufferEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.piplineState(.Basic))
         renderCommanderBufferEncoder?.setVertexBuffer(self.getVerticeBuf(), offset: 0, index: 0)
         renderCommanderBufferEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
         
         renderCommanderBufferEncoder?.endEncoding()
         commanderBuffer?.present(drawable)
         commanderBuffer?.commit()
    }
}



extension GameObject{
    
    func getVerticeBuf() -> MTLBuffer{
        
        func innerInc( value: inout Float, inc: Float, begin: Float){
            if value < 1.0{
                value += inc
            }else{
                value = begin
            }
        }
    
        innerInc(value: &leftx, inc: increasing, begin: -0.5)
        innerInc(value: &bottomleft, inc: increasing, begin: -1.0)
        innerInc(value: &bottomright, inc: increasing, begin: 0.0)
        
        let ranVertice: [Float] =
        [
            leftx,1,0,
            bottomleft,-1,0,
            bottomright,0.5,0,
        ]
        
        let usingStruct = true
        if usingStruct{
            vertices = [
                Vertex(position: float3(leftx,1,0), color: float4(1,0,0,1)),
                Vertex(position: float3(bottomleft,-1,0), color: float4(0,1,0,1)),
                Vertex(position: float3(bottomright,0.5,0), color: float4(0,0,1,1)),
            ]
            return Engine.device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])!
        }
        
        return Engine.device.makeBuffer(bytes: ranVertice, length: vertices.count * MemoryLayout<Float>.size, options: [])!
    }
}
 
