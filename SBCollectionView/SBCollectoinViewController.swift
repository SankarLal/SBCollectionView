

import UIKit

class SBCollectoinViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    var dCollectionView : UICollectionView!
    
    let customeArray = [
        [
            "http://oi43.tinypic.com/25hz7sg.jpg",
            "http://oi44.tinypic.com/16hvtok.jpg",
            "http://www.google.com/intl/en_ALL/images/logo.png",
            "https://www.gstatic.com/webp/gallery3/1.png",
            "https://www.gstatic.com/webp/gallery3/2.png"
        ],
        
        [
            "https://www.gstatic.com/webp/gallery3/3.png",
            "https://www.gstatic.com/webp/gallery3/5.png",
            "https://www.gstatic.com/webp/gallery3/4.png"
        ]
        ,
        [
            "http://www.gstatic.com/webp/gallery/1.jpg",
            "http://www.gstatic.com/webp/gallery/2.jpg",
            "http://www.gstatic.com/webp/gallery/3.jpg"
        ],
        [
            "http://www.gstatic.com/webp/gallery/4.jpg",
            "http://www.gstatic.com/webp/gallery/5.jpg",
            "http://www.bbcode.org/images/lubeck_small.jpg"
        ],
        [
            "http://www.fnordware.com/superpng/pnggrad16rgb.png",
            "https://www.gstatic.com/webp/gallery3/2.png"
        ],
        [
            "https://www.gstatic.com/webp/gallery3/3.png"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "SB Collection View Demo"
        
        setupCollectionView()
    }
    
    func setupCollectionView () {
        
        let dCollectionViewFlowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout ()
        dCollectionView = UICollectionView (frame: self.view.frame, collectionViewLayout: dCollectionViewFlowLayout)
        dCollectionView.delegate = self
        dCollectionView.dataSource = self
        dCollectionView.backgroundColor = UIColor.black
        
        dCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        self.view.addSubview(dCollectionView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        cell.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        
        let lbl_Title : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 1, width: dCollectionView.frame.size.width, height: 30))
        lbl_Title.backgroundColor = UIColor.white
        lbl_Title.textAlignment = .center
        cell.addSubview(lbl_Title)
        
        let scroll: UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 33, width: dCollectionView.frame.size.width, height: 164))
        scroll.delegate = self
        scroll.backgroundColor = UIColor.white
        cell.addSubview(scroll)
        
        var xbase : CGFloat = 10
        
        for i in customeArray[indexPath.row] {
            
            let imgView : UIImageView = UIImageView.init(frame: CGRect.init(x: xbase, y: 7, width: 100, height: 150))
            imgView.layer.cornerRadius = 0.5
            imgView.layer.borderColor = UIColor.red.cgColor
            imgView.layer.borderWidth = 0.5
            scroll.addSubview(imgView)
            xbase += 100 + 10
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            indicator.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
            indicator.color = UIColor.black
            indicator.center = imgView.center
            indicator.startAnimating()
            scroll.addSubview(indicator)
            
            ImageCache.sharedInstance.getImage(url: URL.init(string: i)! , completion: { (image, error) in
                if let _ = error {
                    // thou shall handle errors
                } else if let fullImage = image {
                    imgView.image = fullImage
                    indicator.stopAnimating()
                }
            })
        }
        scroll.contentSize = CGSize.init(width: xbase, height: scroll.frame.size.height)
        lbl_Title.text = "Index Path Row Is \(indexPath.row)"
        
        return cell

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
