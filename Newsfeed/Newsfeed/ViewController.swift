
import UIKit

// huvudklassen som för att kunna använda tableviewn behöver uppfylla visa villkor.
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlet för att få koppling till tableviewn
    @IBOutlet weak var table : UITableView!
    
    // Array som innehåller en InstagramPost med Username, userImage, postImage.
    var models = [InstagramPost]()
    
    // Sätter vem som gör vad och registrerar vem som ska göra vad.
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
      
        
        
        // Lägger till en användare, namn, profilbild och vilken bild personen postat.
        models.append(InstagramPost(NumberOfLikes: 0, username: "Jacob", userImageName: "head", postImageName: "post_1"))
        
        models.append(InstagramPost(NumberOfLikes: 0, username: "Hakim", userImageName: "head", postImageName: "post_1"))
        
        models.append(InstagramPost(NumberOfLikes: 0, username: "Emma", userImageName: "head", postImageName: "post_1"))
        
        print(models.capacity)
        
    } // returnerar antal inlägg per sektion.
    func numberOfSections( in tableView: UITableView) -> Int {
        return 1
    }
    
    // Returnerar antal som finns i models.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    // I tableview:n sätts id för att hitta cellen samt konfgurerar vad som ska finnas med.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: models[indexPath.row])
        cell.bookmarkButtonAction = {
            print(indexPath.row) // Loggar ut index.
        }
        return cell
    }
    // Höjden mellan varje cell. I return justeras så att avståndet mellan cellerna inte blir för stort.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10+110+view.frame.size.width
    }
}

// Vad sätter vad som tas in och dess typ.
struct InstagramPost {
    let NumberOfLikes: Int
    let username: String
    let userImageName : String
    let postImageName : String
}
