//
//  UIImageView+Extension.swift
//  NewsApp
//
//  Created by Nguyễn Duy Việt on 20/7/24.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
        }
    }
}
