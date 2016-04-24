//
//  GLKUpdater.swift
//  ZigzagTriangle
//
//  Created by Kang Jinyeoung on 2016. 4. 24..
//  Copyright © 2016년 SuperbDerrick. All rights reserved.
//

import UIKit
import GLKit

class GLKUpdater: NSObject , GLKViewControllerDelegate{
  
  weak var glkViewController : GLKViewController!
  
  init(glkViewController : GLKViewController) {
   NSLog("%@", "GLKUpdater init!!!!")
    self.glkViewController = glkViewController

  }
  
  
  func glkViewControllerUpdate(controller: GLKViewController) {
   //NSLog("%@", "glkViewControllerUpdate!!!!")
    
  }

}
