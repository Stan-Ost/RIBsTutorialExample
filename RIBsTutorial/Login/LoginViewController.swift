import Anchorage
import RIBs
import RxSwift
import UIKit

///@mockable
protocol LoginPresentableListener: class {
    func didTapLogin(username: String, password: String)
    func didTapCreateAccount()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

    weak var listener: LoginPresentableListener?
    
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let createAccountButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        usernameField.placeholder = "username"
        passwordField.placeholder = "password"
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.backgroundColor = .blue
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        createAccountButton.backgroundColor = .black
        
        activityIndicator.hidesWhenStopped = true
        
        configurelayout()
    }
    
    private func configurelayout() {
        let contentView = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton, createAccountButton])
        contentView.spacing = 16
        contentView.axis = .vertical
        view.addSubview(contentView)
        contentView.centerYAnchor == view.centerYAnchor
        contentView.horizontalAnchors == view.horizontalAnchors + 16
        
        loginButton.heightAnchor == 40
        createAccountButton.heightAnchor == 40
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor == view.centerXAnchor
        activityIndicator.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 16
    }
    
    @objc private func login() {
        if let username = usernameField.text, let password = passwordField.text {
            listener?.didTapLogin(username: username, password: password)
        }
    }
    
    @objc private func createAccount() {
        listener?.didTapCreateAccount()
    }
    
    // MARK - LoginViewControllable
    func present(_ viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    // MARK: - LoginPresentable
    
    func showActivityIndicator(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showErrorAlert() {
        let alertView = UIAlertController(
            title: "Error",
            message: "Cannot login",
            preferredStyle: .alert
        )
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}
