import Foundation


struct BrowseNewsListViewModel {
    private var flags = ["br":"brazil","us":"United State of America","fr":"france","jp":"japan"]
    
}

struct BrowserNewsViewModel {
}


extension BrowseNewsListViewModel {
    
    var numbersOfItemsInSection: Int {
        return flags.count
    }
    
    func flagAt(index:Int) -> String {
        let idx =  flags.index(flags.startIndex, offsetBy: index)
        return flags.values[idx]
    }
    
    func flagKey(index:Int) -> String {
        let idx =  flags.index(flags.startIndex, offsetBy: index)
        return flags.keys[idx]
    }
    
    func firstKeyFlag() -> String {
        let idx =  flags.index(flags.startIndex, offsetBy: 0)
        return flags.keys[idx]
    }
}
