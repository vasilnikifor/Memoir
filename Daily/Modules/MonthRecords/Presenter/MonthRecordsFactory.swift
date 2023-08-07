import UIKit

protocol MonthRecordsFactoryDelegate: AnyObject {
    func openDayRate(day: Day)
    func openNote(day: Day, noteRecord: NoteRecord?)
}

protocol MonthRecordsFactoryProtocol: AnyObject {
    func makeDataSource(
        searchText: String?,
        mode: MonthRecordsMode,
        days: [Day],
        delegate: MonthRecordsFactoryDelegate
    ) -> [MonthRecordsDataSource]

    func makeSharingText(
        days: [Day]
    ) -> NSMutableAttributedString
}

final class MonthRecordsFactory: MonthRecordsFactoryProtocol {
    func makeDataSource(
        searchText: String?,
        mode: MonthRecordsMode,
        days: [Day],
        delegate: MonthRecordsFactoryDelegate
    ) -> [MonthRecordsDataSource] {
        var dataSource: [MonthRecordsDataSource] = []

        days.forEach { day in
            guard !day.isEmpty else { return }

            let records: [Record] = (day.records ?? [])
                .compactMap { record in
                    guard let record = record as? Record else { return nil }
                    guard let searchText = searchText?.trimmingCharacters(in: .whitespaces), !searchText.isEmpty else { return record }
                    guard let noteRecord = record as? NoteRecord else { return nil }

                    if noteRecord.text?.range(of: searchText, options: .caseInsensitive) != nil {
                        return noteRecord
                    } else {
                        return nil
                    }
                }

            if records.isEmpty { return }

            dataSource.append(
                makeHeader(
                    day: day,
                    mode: mode,
                    delegate: delegate
                )
            )

            records
                .sorted { record1, record2 in
                    guard let record1Time = record1.time, let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .forEach { record in
                    if let noteRecord = record as? NoteRecord {
                        dataSource.append(
                            .note(
                                viewModel: MonthRecordsRecordViewModel(
                                    text: noteRecord.text.orEmpty,
                                    time: (noteRecord.time ?? Date()).timeRepresentation,
                                    action: { [weak delegate] in delegate?.openNote(day: day, noteRecord: noteRecord)}
                                )
                            )
                        )
                    }
                }

            dataSource.append(
               makeActions(day: day, delegate: delegate)
            )
        }

        return dataSource
    }

    func makeSharingText(
        days: [Day]
    ) -> NSMutableAttributedString {
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 27),
            NSAttributedString.Key.foregroundColor: UIColor.dPrimaryText,
        ]
        let timeAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.dSecondaryText,
        ]
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.dPrimaryText,
        ]

        let text = days.reduce(into: NSMutableAttributedString()) { result, day in
            guard !day.isEmpty, let date = day.date  else { return }

            let dateTitle = makeDateTitle(date: date, rate: day.rate)
            let dateAttributedTitle = NSAttributedString(string: dateTitle, attributes: titleAttributes)
            result.append(dateAttributedTitle)

            (day.records ?? [])
                .compactMap { record in
                    return record as? NoteRecord
                }
                .sorted { l, r in
                    guard let lTime = l.time, let rTime = r.time else { return false }
                    return lTime < rTime
                }
                .forEach { noteRecord in
                    if let time = noteRecord.time, let text = noteRecord.text {
                        result.append(
                            NSAttributedString(
                                string: .lineBreak + time.timeRepresentation + .lineBreak,
                                attributes: timeAttributes
                            )
                        )
                        result.append(
                            NSAttributedString(
                                string: text + .lineBreak,
                                attributes: textAttributes
                            )
                        )
                    }
                }

            let daySpaceText = .lineBreak + .lineBreak + .lineBreak
            let daySpace = NSAttributedString(string: daySpaceText, attributes: titleAttributes)
            result.append(daySpace)
        }

        return text
    }

    private func makeDateTitle(date: Date, rate: DayRate?) -> String {
        if let rate {
            return date.dateFullRepresentation + .space + rate.emoji + .lineBreak
        } else {
            return date.dateFullRepresentation + .lineBreak
        }
    }

    private func makeHeader(
        day: Day,
        mode: MonthRecordsMode,
        delegate: MonthRecordsFactoryDelegate
    ) -> MonthRecordsDataSource {
        let title: String
        switch mode {
        case .month:
            title = day.date?.dateShortRepresentation ?? .empty
        case .year:
            title = day.date?.dateRepresentation ?? .empty
        }

        let isRateIconVisible: Bool
        let rateIconImage: UIImage?
        let rateIconTint: UIColor?
        switch day.rate {
        case .none:
            isRateIconVisible = false
            rateIconImage = nil
            rateIconTint = nil
        case .bad:
            isRateIconVisible = true
            rateIconImage = .badRateFilled
            rateIconTint = .dBadRateColor
        case .average:
            isRateIconVisible = true
            rateIconImage = .averageRateFilled
            rateIconTint = .dAverageRateColor
        case .good:
            isRateIconVisible = true
            rateIconImage = .goodRateFilled
            rateIconTint = .dGoodRateColor
        }
        
        return .header(
            viewModel: MonthRecordsHeaderViewModel(
                title: title,
                isRateIconVisible: isRateIconVisible,
                rateIconImage: rateIconImage,
                rateIconTint: rateIconTint,
                action: { [weak delegate] in delegate?.openDayRate(day: day) }
            )
        )
    }

    private func makeActions(
        day: Day,
        delegate: MonthRecordsFactoryDelegate
    ) -> MonthRecordsDataSource {
        let rateImage: UIImage
        let rateTintColor: UIColor
        
        switch day.rate {
        case .none:
            rateImage = .rateDay
            rateTintColor = .dPrimaryTint
        case .bad:
            rateImage = .badRateFilled
            rateTintColor = .dBadRateColor
        case .average:
            rateImage = .averageRateFilled
            rateTintColor = .dAverageRateColor
        case .good:
            rateImage = .goodRateFilled
            rateTintColor = .dGoodRateColor
        }

        return .actions(
            viewModel: MonthRecordsFooterViewModel(
                rateImage: rateImage,
                rateTintColor: rateTintColor,
                rateAction: { [weak delegate] in delegate?.openDayRate(day: day) },
                addNoteAction: { [weak delegate] in delegate?.openNote(day: day, noteRecord: nil) }
            )
        )
    }
}
