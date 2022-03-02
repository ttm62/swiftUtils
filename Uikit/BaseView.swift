//
//  DT_BaseView.swift
//  TripiPrepaidKit
//
//  Created by ttm62 on 24/01/2022.
//

import Foundation

class DTBaseView: UIView {
    @IBOutlet weak var contentView: UIView!
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private
    func customInit() {
        let bundle = Bundle(for: Self.self)
        let name = String(describing: type(of: self))
        bundle.loadNibNamed(name, owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        
        initialize()
    }
    
    func initialize() {
        // YOUR CODE GOES HERE
    }
}

