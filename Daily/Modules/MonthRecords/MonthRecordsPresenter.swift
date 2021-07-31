import UIKit

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
}

final class MonthRecordsPresenter {
    private weak var view: MonthRecordsViewControllerProtocol?
    private let dayService: DayServiceProtocol
    private let month: Date
    
    init(view: MonthRecordsViewControllerProtocol,
        inputModel: MonthRecordsInputModel,
        dayService: DayServiceProtocol) {
        self.view = view
        self.dayService = dayService
        month = inputModel.month
    }
    
    
    private func openNote(day: Day, noteRecord: NoteRecord) {
        guard let date = day.date else { return }
        
        view?.present(
            DayNoteAssembler.assemble(
                DayNoteInputModel(
                    date: date,
                    note: noteRecord,
                    delegate: self
                )
            )
        )
    }
    
    private func openDayRate(day: Day) {
        guard let date = day.date else { return }
        
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: date,
                    selectedRate: day.rate,
                    delegate: self
                )
            )
        )
    }
}

extension MonthRecordsPresenter: MonthRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(title: month.monthRepresentation)
        update()
    }
}

extension MonthRecordsPresenter: CalendarDelegate {
    func update() {
        var dataSource: [MonthRecordsDataSource] = []
            
        dayService.getDays(of: month).forEach { day in
            guard !day.isEmpty else { return }
            
            let rateImage: UIImage?
            let rateImageTintColor: UIColor?
            switch day.rate {
            case .none:
                rateImage = nil
                rateImageTintColor = nil
            case .bad:
                rateImage = Theme.badRateImage
                rateImageTintColor = Theme.badRateColor
            case .average:
                rateImage = Theme.averageRateImage
                rateImageTintColor = Theme.averageRateColor
            case .good:
                rateImage = Theme.goodRateImage
                rateImageTintColor = Theme.goodRateColor
            }
            
            dataSource.append(
                .dayHeader(
                    viewModel: DayHeaderViewModel(
                        title: day.date?.dateRepresentation ?? "",
                        image: rateImage,
                        imageTintColor: rateImageTintColor,
                        action: { [weak self] in self?.openDayRate(day: day)}
                    )
                )
            )
            
            day.records?
                .sorted { record1, record2 in
                    guard let record1 = record1 as? Record,
                          let record1Time = record1.time,
                          let record2 = record2 as? Record,
                          let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .forEach { record in
                    if let noteRecord = record as? NoteRecord {
                        dataSource.append(
                            .note(
                                viewModel: NoteRecordViewModel(
                                    text: noteRecord.text ?? "",
                                    time: (noteRecord.time ?? Date()).timeRepresentation,
                                    action: { [weak self] in self?.openNote(day: day, noteRecord: noteRecord)}
                                )
                            )
                        )
                    }
                }
        }
        
        view?.update(dataSource: dataSource)
    }
}
