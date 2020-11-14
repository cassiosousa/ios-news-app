import Foundation


struct BrowseNewsListViewModel {
    private let flags: KeyValuePairs = ["br":"brazil","us":"United State of America","fr":"france","jp":"japan"]
    
}

struct BrowserNewsViewModel {
}


extension BrowseNewsListViewModel {
    
    var numbersOfItemsInSection: Int {
        return flags.count
    }
    
    func flagAt(index:Int) -> String? {
        if !flags.indices.contains(index)  { return .none }
        let idx =  flags.index(flags.startIndex, offsetBy: index)
        return flags[idx].value
    }
    
    func flagKey(index:Int) -> String? {
        if !flags.indices.contains(index)  { return .none }
        let idx =  self.flags.index(flags.startIndex, offsetBy: index)
        return self.flags[idx].key
    }
    
    func firstKeyFlag() -> String {
        let idx =  flags.index(flags.startIndex, offsetBy: 0)
        return flags[idx].key
    }
    func firstValueFlag() -> String {
        let idx =  flags.index(flags.startIndex, offsetBy: 0)
        return flags[idx].value
    }
}
