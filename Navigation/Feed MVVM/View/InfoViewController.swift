//
//  InfoViewController.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Subviews & data

    var residentNames: [String] = []

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title is loading, please wait..."
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    private lazy var tatooineOrbitalPeriodLabel: UILabel = {
        let tatooineOrbitalPeriodLabel = UILabel()
        tatooineOrbitalPeriodLabel.text = "Calculating..."
        tatooineOrbitalPeriodLabel.textColor = .white
        tatooineOrbitalPeriodLabel.translatesAutoresizingMaskIntoConstraints = false
        return tatooineOrbitalPeriodLabel
    }()

    private lazy var residentsTable: UITableView = {
        let residentsTable = UITableView(frame: .zero, style: .plain)
        residentsTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        residentsTable.translatesAutoresizingMaskIntoConstraints = false
        return residentsTable
    }()

    private lazy var showAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Alert", for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown

        setupSubview()
        setTitleLabelText()
        setTatooineOrbitalPeriodLabelText()
        getResidents()
    }

    // MARK: - Setup view

    private func setupSubview() {
        view.addSubview(showAlertButton)
        view.addSubview(titleLabel)
        view.addSubview(tatooineOrbitalPeriodLabel)
        view.addSubview(residentsTable)
        residentsTable.dataSource = self
        residentsTable.delegate = self
        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            showAlertButton.widthAnchor.constraint(equalToConstant: 100),
            showAlertButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            showAlertButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),

            tatooineOrbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tatooineOrbitalPeriodLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            tatooineOrbitalPeriodLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),

            residentsTable.topAnchor.constraint(equalTo: tatooineOrbitalPeriodLabel.bottomAnchor, constant: 16),
            residentsTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            residentsTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            residentsTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

    // MARK: - Alert button action

    @objc private func tap() {
        let vc = UIAlertController(title: "Hello", message: "Do you like my homework?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) {
            UIAlertAction in
            NSLog("All right")
        }
        let cancelAction = UIAlertAction(title: "Not quite", style: .default) {
            UIAlertAction in
            NSLog("Needs to be improved")
        }
        vc.addAction(cancelAction)
        vc.addAction(okAction)
        present(vc, animated: true)
    }

    // MARK: - Task 1

    private func setTitleLabelText() {
        getTitle { title in
            DispatchQueue.main.async {
                self.titleLabel.text = title
            }
        }
    }

    // MARK: - Task 2

    private func setTatooineOrbitalPeriodLabelText() {
        getRotationPeriod { period in
            guard (period != nil) else { return }
            DispatchQueue.main.async {
                self.tatooineOrbitalPeriodLabel.text = "Tatooine orbital period is \(period!)"
            }
        }
    }

    // MARK: - Task 3

    private func getResidents() {
        getResidentsArray { residentsArray in
            let group = DispatchGroup()
            for resident in residentsArray! {
                guard let url = URL(string: resident) else { return }
                let session = URLSession(configuration: .default)
                group.enter()
                let task = session.dataTask(with: url) { data, _, error in
                    do {
                        guard let data = data else { return }
                        let model = try JSONDecoder().decode(Residents.self, from: data)
                        self.residentNames.append(model.name)
                        group.leave()
                    } catch let error as NSError {
                        print("Error: \(error.localizedDescription)")
                    }
                }
                task.resume()
            }
            group.notify(queue: .main) {
                self.residentsTable.reloadData()
            }
        }
    }

    // MARK: - Setup TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .systemGray6
        cell.textLabel?.text = self.residentNames[indexPath.row]
        return cell
    }
}

class TableViewCell: UITableViewCell {
    //empty
}
