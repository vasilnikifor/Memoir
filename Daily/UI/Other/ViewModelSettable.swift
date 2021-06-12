import Foundation

protocol ViewModelSettable: AnyObject {
    func setup(with viewModel: ViewModel)
}
