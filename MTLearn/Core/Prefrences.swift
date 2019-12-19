//
//  Prefrences.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import MetalKit

public enum ClearColor{
    static let Green: MTLClearColor = MTLClearColorMake(0.2, 0.8, 0.1, 1)
}

class Preferences{
    
    public static var ClearClear: MTLClearColor = ClearColor.Green
    
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
    
}
