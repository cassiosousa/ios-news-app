

struct CategoryListViewModel {
    private let categoryViewModel:[CategoryViewModel]
    
    init() {
        self.categoryViewModel = Category.allCases.map(CategoryViewModel.init)
    }
}

struct CategoryViewModel {
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
}

extension CategoryViewModel {
    var name: String {
        return category.rawValue.capitalized
    }
}

extension CategoryListViewModel {
    
    var numbersOfSection: Int {
        return 1
    }
    
    var numberOfItemsInSection: Int {
        return self.categoryViewModel.count
    }
    
    func categoryAt(index: Int) -> CategoryViewModel {
        return self.categoryViewModel[index]
    }
}
