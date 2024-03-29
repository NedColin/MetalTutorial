import simd


protocol sizeable{
    static func size(_ count: Int) -> Int
    static func stride(_ count: Int) -> Int
}

extension sizeable{
    static func size() -> Int{
        return MemoryLayout<Self>.size
    }
    
    static func stride() -> Int{
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int{
        return MemoryLayout<Self>.size * count
    }
    static func stride(_ count: Int) -> Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension float3: sizeable{
    
}

struct Vertex: sizeable {
    var position : float3
    var color : float4
}
