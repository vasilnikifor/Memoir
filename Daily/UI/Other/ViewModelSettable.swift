import Foundation

protocol ViewModelSettable: AnyObject {
    associatedtype ViewModel
    func setup(with viewModel: ViewModel)
}
