import UIKit

public class ImageDrawer {
    public static func showImage(with url: String) -> UIImage {
        let imageUrl = URL(string: url)
        let data = try? Data(contentsOf: imageUrl!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

        if let dataImage = data, let image = UIImage(data: dataImage) {
            return image
        }

        return UIImage()
    }
}

