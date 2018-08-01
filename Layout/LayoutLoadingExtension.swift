//
//  LayoutLoadingExtension.swift
//  Layout
//
//  Created by Rikard Petre on 2018-01-24.
//

import Foundation

public var globalLayoutConstants = [String: Any]();
public var mainBundle : Bundle? = nil;

extension LayoutLoading {
    
    public func loadLayout(name: String, state: Any? = nil, subStates: [String: Any]? = nil, constants: [String : Any]? = nil) {
        
        assert(mainBundle != nil, "mainBundle cant be nil!!!!!!!");
        //self.loadLayout(named: "res/layout/\(name).xml", bundle: mainBundle!, state: state ?? (), subStates: subStates ?? [:], constants: globalLayoutConstants, constants ?? [:]);
        
        if let url = mainBundle!.url(forResource: name, withExtension: "xml", subdirectory: "res/layout") {           
            self.loadLayout(withContentsOfURL: url, state: state ?? (), subStates: subStates ?? [:], constants: globalLayoutConstants, constants ?? [:], completion: { (error) in
                if let error = error {
                    print(error);
                }
            })
        }
        else {
            print("Did not find layout file with the name:", name);
        }
        
    }
}

public func layoutWithName(_ name : String, state: Any? = nil, constants: [String : Any]? = nil) -> LayoutNode? {
    assert(mainBundle != nil, "mainBundle cant be nil!!!!!!!");
    if let url = mainBundle!.url(forResource: name, withExtension: "xml", subdirectory: "res/layout") {
        do {
            let node = try LayoutNode(xmlData: Data(contentsOf: url), url: url)
            
            return node;
        }
        catch let e {
            print("Failed to load node:", e.localizedDescription);
        }
        
    }
    else {
        print("Did not find layout file with the name:", name);
    }
    return nil;
}
