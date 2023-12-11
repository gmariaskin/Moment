
import UIKit

class GuidelinesViewController: CustomViewController, UITextViewDelegate {
    private let mainView: GuidelinesView
    private var state: GuidelinesState
    
    init(state: GuidelinesState) {
        self.state = state
        mainView = GuidelinesView(state: state)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {

        mainView.textView.delegate = self
        switch state {
        case .privacyPolicy:
            mainView.configureText(with: configureTextView(fileName: "privacyPolicy"))
        case .termsOfUse:
            mainView.configureText(with: configureTextView(fileName: "terms"))
        }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

    }
    
    private func configureTextView(fileName: String) -> NSAttributedString {
        var attributedText: NSAttributedString?
        
        if let rtfPath = Bundle.main.url(forResource: fileName, withExtension: "rtf") {
            do {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.rtf,
                ]
                
                let attributedStringWithRtf = try NSMutableAttributedString(url: rtfPath, options: options, documentAttributes: nil)
                
         
                let range = NSRange(location: 0, length: attributedStringWithRtf.length)
                attributedStringWithRtf.addAttribute(.foregroundColor, value: UIColor.black, range: range)
                
              //  let font =
            //   attributedStringWithRtf.addAttribute(.font, value: font, range: range)
                
                attributedText = attributedStringWithRtf
            } catch {
                print("Got an error \(error)")
            }
        }
        
        return attributedText ?? NSAttributedString(string: "")
    }
    
 
}
