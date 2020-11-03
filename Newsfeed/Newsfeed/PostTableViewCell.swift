//
//  PostTableViewCell.swift
//  Newsfeed
//
//  Created by Jacob  Ehnvall on 2020-10-22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // Kopplingar till olika UI element som kommer från biblioteket i Xcode.
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var SendComments: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var userInputField: UITextField!
    @IBOutlet var saveImageInstance : UIButton!
    
    
    @IBOutlet var LikeButton: UIButton!
    @IBOutlet var likesLabel: UILabel!
        
    var bookmarkButtonAction : (() -> ())?

    
    // Tar in det som skrivs i fälltet (om det finns något) och skickar det till en "kommentars label"
    var competionHandler : ((String?) -> Void)?
    
    // Håller koll på Like. Satt värde på ett för att det inte ska bli minus!
    var like : Int = 1

    // Meddelandet skickas med save knapp och tar med det som finns i fälltet.
    // clearbutton används för att användaren får en
    //kryssknapp och kan ta bort det som är skrivet i fältet.
    
    @IBAction func Savebutton() {
        competionHandler?(userInputField.text)
        competionHandler = {text in
        self.SendComments.text = text}
        userInputField.clearButtonMode = .always
    }
    
    @IBAction func didButtonClick(_ sender: UIButton) {
        bookmarkButtonAction?()
    }
    
//     func saveImage(index : Int) {
//     saveImageInstance.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
//     print(index)
//    }
        
    // Knapp för när användaren klickar på "Like"
    @IBAction func LkeButtonPressed(_ sender: Any) {
        if LikeButton.tag == 0 {
            
            // Bild som byts om användaren trycker like. Like blir minus.
            LikeButton.setImage(UIImage(named:"heart_1"), for: .normal)
            LikeButton.tag = 1
            like -= 1
        }
        //Bilden byts ut till ett fyllt hjärta när användaren trycker på den.
        // liken ökar med ett.
        else {
            LikeButton.setImage(UIImage(named:"heart_2"), for: .normal)
            LikeButton.tag = 0
            like += 1
        }
        
        // funktion för att få se om du har tryckt like eller tagit bort den.
        updateLike()
        
        
    } //Lättare kunna komma åt satta id:en på flera ställen i klasser.
    static let identifier = "PostTableViewCell"
    
    // Funktion för att returnera cellen (xib/nib.)
    static func nib() -> UINib {
        return  UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    // Skickar meddelande till varje nib/xib objekt när den har initaliserats.
    override func awakeFromNib() {
        super.awakeFromNib()
        self.saveImageInstance.addTarget(self, action: #selector(didButtonClick(_:)), for: .touchUpInside)
    }
    override func setSelected( _ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    // Kollar vad som finns i appen innan programmet körs.
    func configure(with model: InstagramPost) {
     self.likesLabel.text  = "\(model.NumberOfLikes) Like"
     self.usernameLabel.text = model.username
     self.userImageView.image = UIImage(named: model.userImageName)
     self.postImageView.image = UIImage(named: model.postImageName)
     }
    
    // Like function för att se om användaren har tryckt like
    func updateLike() {
        likesLabel.text = "\(like) Like"
    }
}
