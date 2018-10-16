//
//  ViewController.swift
//  MagicHat
//
//  Created by Steele Haley on 10/1/18.
//  Copyright © 2018 Steele Haley. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var hasRendered: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        /*let scene = SCNScene(named: "art.scnassets/hat.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene*/
        hasRendered = false
        
        sceneView.scene = SCNScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    private var planeNode: SCNNode?
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if (anchor is ARPlaneAnchor) {
            if (hasRendered == false) {
                print("Found Anchor")
                guard let url = Bundle.main.url(forResource: "art.scnassets/hat", withExtension: "scn") else {
                    NSLog("Could not find door scene")
                    return nil
                }
                guard let node = SCNReferenceNode(url: url) else { return nil }
                print("Added Anchor")
                node.load()
                //let sphere = SCNSphere(radius: 0.1)
                //let contentNode = SCNNode(geometry: sphere)
                planeNode = SCNNode()
                planeNode?.addChildNode(node)
                hasRendered = true
                return planeNode
            }
        }
        return nil
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
