//
//  WeatherContainerViewController.swift
//  MyWeather
//
//  Created by Hyeontae on 02/08/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import MapKit

class WeatherContainerViewController: UIPageViewController {
    
    var initialIndex = 0
    var pageSources: [RegionInformation]!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private var nowPageIndex = 0
    private lazy var pageViewControllers: [UIViewController?] = {
        return Array<RegionWeatherViewController?>(repeating: nil, count: pageSources.count)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageViewController()
    }
    
    private func setPageViewController() {
        self.delegate = self
        self.dataSource = self
        nowPageIndex = initialIndex
        setViewControllers([pageSourceViewController(initialIndex)], direction: .forward, animated: true, completion: nil)
    }
    
    private func pageSourceViewController(_ index: Int) -> RegionWeatherViewController {
        guard let viewController = UIStoryboard(name: "RegionWeather", bundle: nil).instantiateInitialViewController() as? RegionWeatherViewController else {
            fatalError("RegionWeather Storyboard Error")
        }
        viewController.pageIndex = index + 1
        viewController.totalIndex = pageSources.count
        viewController.regionInformation = pageSources[index]
        pageViewControllers[index] = viewController
        return viewController
    }
    
}

// MARK: - UIPageViewControllerDataSource

extension WeatherContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let previousIndex = nowPageIndex - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        if let beforeViewController = pageViewControllers[previousIndex] {
            return beforeViewController
        } else {
            pageViewControllers[previousIndex] = pageSourceViewController(previousIndex)
            return pageViewControllers[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let afterIndex = nowPageIndex + 1
        
        if afterIndex >= pageSources.count {
            return nil
        }
        
        if let afterViewController = pageViewControllers[afterIndex] {
            return afterViewController
        } else {
            pageViewControllers[afterIndex] = pageSourceViewController(afterIndex)
            return pageViewControllers[afterIndex]
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension WeatherContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let nowPageViewController = pageViewController.viewControllers?.first,
            let pageIndex = pageViewControllers.firstIndex(of: nowPageViewController)
            else { return }
        nowPageIndex = pageIndex
    }
}
