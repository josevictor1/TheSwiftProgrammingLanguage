import UIKit

public class ImagePresenter {
    public static func showImage(with url: String) -> UIImage {
        guard let imageUrl = URL(string: url) else { return UIImage() }
        let data = try? Data(contentsOf: imageUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

        if let dataImage = data, let image = UIImage(data: dataImage) {
            return image
        }

        return UIImage()
    }
}

