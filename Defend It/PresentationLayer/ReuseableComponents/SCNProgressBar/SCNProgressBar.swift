//
//  SCNProgressBar.swift
//  Defend It
//
//  Created by Роман Сенкевич on 4.08.22.
//

import SceneKit

class SCNProgressBar: SCNNode {
    
    /// The color shown for the portion of the progress bar that is filled.
    var progressTintColor: UIColor = .green {
        didSet {
            setColor(progressTintColor, to: progressPlane)
        }
    }
    
    /// The color shown for the portion of the progress bar that is not filled.
    var trackTintColor: UIColor = .black {
        didSet {
            setColor(trackTintColor, to: trackPlane)
        }
    }
    
    /// ranked from 0.0 to 1.0
    var progress: CGFloat = 0 {
        didSet {
            if progress > 1 {progress = 1}
            setProgressTint(to: progress)
        }
    }
    
    private var size: CGSize = CGSize(width: 0, height: 0)
    
    /// trackPlane is the root object of the geometry of this class
    private var trackPlane: SCNPlane!
    
    /// progressNode is a  child node for this class.
    private var progressNode: SCNNode!
    
    /// progressPlane is the root object of the geometry of the progressNode
    /// This hierarchy is fundamentally important so that there are no problems with billboard constreints
    private var progressPlane: SCNPlane!
    
    
    init(width: CGFloat, height: CGFloat) {
        super.init()
        self.size = CGSize(width: width, height: height)
        setupTrackTint()
        setupProgressTint()
        addBillboardConstraint()
        setNodeNames()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    private func setupTrackTint() {
        trackPlane = SCNPlane(width: size.width, height: size.height)
        trackPlane.cornerRadius = 1
        self.geometry = trackPlane
        setColor(trackTintColor, to: trackPlane)
    }
    
    private func setupProgressTint() {
        progressNode = SCNNode()
        progressPlane = SCNPlane()
        progressPlane.cornerRadius = 1
        progressNode.geometry = progressPlane
        setProgressTint(to: progress)
        setColor(progressTintColor, to: progressPlane)
        addChildNode(progressNode)
    }
    
    
    /// We use SCNPlane objects to display our progress.
    /// Therefore, this function adjusts the color of the SCNPlane objects.
    private func setColor(_ newColor: UIColor, to plane: SCNPlane) {
        let progressPlaneMaterial = SCNMaterial()
        progressPlaneMaterial.diffuse.contents = newColor
        plane.materials = [progressPlaneMaterial]
    }
    
    /// The function adjusts the size of the progressTint.
    /// When the progressTint sizes change, it increases or decreases at both ends.
    /// Since the coordinate (0, 0) is in the middle of the progressTint.
    /// Therefore, we offset progressTint along the Ox axis, by a distance equal to half of the change.
    private func setProgressTint(to newValue: CGFloat) {
        progressPlane.width = size.width * newValue
        progressPlane.height = size.height
        let offset: CGFloat = size.width * (1 - newValue) / 2 * -1
        progressNode.position = SCNVector3(offset, 0.005, 0.005)
    }
    
    /// These constraints guarantee us that we will always have the status bar pointing perpendicular to us.
    private func addBillboardConstraint() {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .all
        self.constraints = [billboardConstraint]
    }
    
    /// We name all the nodes in order to be able to refer to them later
    private func setNodeNames() {
        name = NodeNames.progressBar.rawValue
        trackPlane.name = NodeNames.trackPlane.rawValue
        progressNode.name = NodeNames.progressNode.rawValue
        progressPlane.name = NodeNames.progressPlane.rawValue
    }
}
