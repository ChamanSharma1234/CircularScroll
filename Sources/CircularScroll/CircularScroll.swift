import UIKit

public class CircularScroll : UIView, UIScrollViewDelegate {
    public var images = [String]()
    var pageControl = UIPageControl()
    var scrollView = UIScrollView()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        self.initialMakeup(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initialMakeup(frame: CGRect) {
        self.frame = frame
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        backgroundColor = UIColor.white
        self.scrollView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.scrollView.delegate = self
        addSubview(self.scrollView)
        pageControl.frame = CGRect(x: 0, y: frame.size.height - 50, width: frame.size.width, height: 50)
        addSubview(self.pageControl)
    }
    
    
    public func setup(view : UIView) {
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        if !images.isEmpty {
            var modifiedBannerItemList = images
            if modifiedBannerItemList.count > 1 {
                modifiedBannerItemList.insert(images[images.count - 1], at: 0)
                modifiedBannerItemList.append(images[0])
            }
            pageControl.numberOfPages = images.count
            pageControl.currentPage = 0
            var xPosition : CGFloat = 0.0
            for image in modifiedBannerItemList {
                let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width:frame.size.width, height: frame.size.height))
                imageView.contentMode = .scaleToFill
                imageView.image = UIImage(named: image)
                self.scrollView.addSubview(imageView)
                xPosition = xPosition + frame.size.width
            }
            self.scrollView.setContentOffset(CGPoint(x: frame.size.width, y: 0), animated: false)
            self.scrollView.contentSize = CGSize(width: (frame.size.width * CGFloat(modifiedBannerItemList.count)), height: 0)
        }
        view.addSubview(self)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if Int(pageNumber) >= self.scrollView.subviews.count - 1 {
            pageControl.currentPage = 0
            self.scrollView.contentOffset = CGPoint(x:frame.size.width, y: 0)
        } else if Int(pageNumber) == 0 {
            pageControl.currentPage = images.count
            self.scrollView.contentOffset = CGPoint(x:(frame.size.width * CGFloat(self.scrollView.subviews.count - 2)), y: 0)
        } else {
            pageControl.currentPage = Int(pageNumber - 1)
        }
    }
    
}
