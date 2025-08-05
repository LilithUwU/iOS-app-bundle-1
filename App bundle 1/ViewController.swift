import UIKit

class ViewController: UIViewController {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.layer.cornerRadius = 8
        return tv
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let appendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Append", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadTapped), for: .touchUpInside)
        appendButton.addTarget(self, action: #selector(appendTapped), for: .touchUpInside)
    }

    func setupLayout() {
        view.addSubview(textView)
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        view.addSubview(appendButton)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 400),

            saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 100),

            loadButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loadButton.widthAnchor.constraint(equalToConstant: 100),
            
            appendButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            appendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appendButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    @objc func saveTapped() {
        let text = textView.text ?? ""
        let success = MyTextFileManager.save(text: text)
        showAlert(
            title: success ? "Success" : "Error",
            message: success ? "File saved successfully." : "Failed to save.")
    }

    @objc func loadTapped() {
        if let content = MyTextFileManager.read() {
            textView.text = content
        } else {
            showAlert(title: "Error", message: "No file found")
        }
    }
    
    @objc func appendTapped() {
        let text = textView.text ?? ""
        let success = MyTextFileManager.append(text: text)
        showAlert(
            title: success ? "Success" : "Error",
            message: success ? "Text appended successfully." : "Failed to append.")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
