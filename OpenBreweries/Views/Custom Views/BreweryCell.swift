//
//  BreweryCell.swift
//  OpenBreweries
//
//  Created by Chad Rutherford on 5/12/21.
//

import SwiftUI
import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

final class BreweryCell: UITableViewCell {

    var brewery: Brewery? {
        didSet {
            updateViews()
        }
    }

    let breweryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "HI! NAME HERE!"
        return label
    }()

    let breweryAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "HI! ADDRESS HERE!"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(breweryNameLabel)
        addSubview(breweryAddressLabel)

        NSLayoutConstraint.activate([
            breweryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            breweryNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            breweryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            breweryAddressLabel.leadingAnchor.constraint(equalTo: breweryNameLabel.leadingAnchor),
            breweryAddressLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            breweryAddressLabel.topAnchor.constraint(equalTo: breweryNameLabel.bottomAnchor, constant: 8),
            breweryAddressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func updateViews() {
        guard let brewery = brewery else { return }
        breweryNameLabel.text = brewery.name
        breweryAddressLabel.text = brewery.address
    }
}

extension BreweryCell: ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

struct BreweryCellPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .previewLayout(.sizeThatFits)
    }

    struct ContainerView: UIViewRepresentable {
        func updateUIView(_ uiView: UIViewType, context: Context) {

        }

        func makeUIView(context: Context) -> some BreweryCell {
            return BreweryCell()
        }
    }
}
