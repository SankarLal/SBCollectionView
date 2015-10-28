

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
        dCollectionView.backgroundColor = UIColor.blackColor()
        
        dCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        self.view.addSubview(dCollectionView)
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customeArray.count
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: self.view.frame.size.width, height: 200)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        
        
        let lbl_Title : UILabel = UILabel(frame: CGRectMake(0, 1, dCollectionView.frame.size.width, 30))
        lbl_Title.backgroundColor = UIColor.whiteColor()
        lbl_Title.textAlignment = .Center
        cell.addSubview(lbl_Title)
        
        let scroll: UIScrollView = UIScrollView(frame: CGRectMake(0, 33, dCollectionView.frame.size.width, 164))
        scroll.delegate = self
        scroll.backgroundColor = UIColor.whiteColor()
        cell.addSubview(scroll)
        
        var xbase : CGFloat = 10
        
        for i in customeArray[indexPath.row] {
            
            let imgView : UIImageView = UIImageView(frame: CGRectMake(xbase, 7, 100, 150))
            imgView.layer.cornerRadius = 0.5
            imgView.layer.borderColor = UIColor.redColor().CGColor
            imgView.layer.borderWidth = 0.5
            scroll.addSubview(imgView)
            xbase += 100 + 10
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            indicator.frame = CGRectMake(0, 0, 25, 25)
            indicator.color = UIColor.blackColor()
            indicator.center = imgView.center
            indicator.startAnimating()
            scroll.addSubview(indicator)
            
            ImageCache.sharedInstance.getImage(NSURL(string: i)!){ image, error in
                if let _ = error {
                    // thou shall handle errors
                } else if let fullImage = image {
                    imgView.image = fullImage
                    indicator.stopAnimating()
                }
            }
        }
        
        scroll.contentSize = CGSizeMake(xbase, scroll.frame.size.height)
        lbl_Title.text = "Index Path Row Is \(indexPath.row)"
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
