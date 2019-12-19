//
//  File.metal
//  MTLearn
//
//  Created by Ting on 12/11/19.
//  Copyright © 2019 Ned. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

//-----------------------  3. using MTLVertexDescriptor  --------------------------------------
struct VertexIn{
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};
struct RasterizerData{
    float4 position [[ position ]];
    float4 color;
};

vertex RasterizerData vertex_shader(const VertexIn vIn [[ stage_in ]]){
    RasterizerData rd;
    rd.position = float4(vIn.position, 1);
    rd.color = vIn.color;
    return rd;
}

fragment half4 fragment_shader(RasterizerData rd [[stage_in]]){
    float4 color = rd.color;
    return half4(color.r,color.g,color.b,color.a);
}



//-----------------------  2. using struct data type  --------------------------------------
/*
struct VertexIn{
    float3 position;
    float4 color;
};

struct RasterizerData{
    float4 position [[ position ]];
    float4 color;
};
    

vertex RasterizerData vertex_shader(device VertexIn * vertices [[ buffer(0) ]], uint vertexId [[ vertex_id ]]){
    RasterizerData rd;
    rd.position = float4(vertices[vertexId].position, 1);
    rd.color = vertices[vertexId].color;
    return rd;
}

fragment half4 fragment_shader(RasterizerData rd [[stage_in]]){
    float4 color = rd.color;
    return half4(color.r,color.g,color.b,color.a);
}
*/



//-----------------------  1. using [float] data type  --------------------------------------

/*
 
vertex float4 vertex_shader(const device packed_float3 * vertices [[ buffer(0) ]], uint vertexId [[ vertex_id ]]){
    return float4(vertices[vertexId], 1);
}

fragment half4 fragment_shader(){
    return half4(1, 0, 0, 1);
}
 */
