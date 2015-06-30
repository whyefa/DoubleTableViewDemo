//
//  ViewController.swift
//  DoubleTableViewDemo
//
//  Created by Developer on 15/6/30.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

import UIKit

let kScreenHeight = UIScreen.mainScreen().bounds.height
let kScreenWidth = UIScreen.mainScreen().bounds.width
let titleIndenifier = "titleCell"
let infoIndentifier = "infoCell"
let kOriginX = CGFloat(120)

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var titleTable: UITableView!
    var infoTable: UITableView!
    var contentView: UIScrollView!
    var infoRank: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableHeader()
         titleTable = UITableView(frame: CGRectMake(CGFloat(0), CGFloat(40), kOriginX, kScreenHeight), style: UITableViewStyle.Plain)
        titleTable.dataSource = self
        titleTable.delegate = self
        titleTable.separatorStyle = UITableViewCellSeparatorStyle.None
        titleTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: titleIndenifier)
        self.view.addSubview(titleTable)
        
        contentView = UIScrollView(frame: CGRectMake(kOriginX, 40, kScreenWidth - kOriginX, kScreenHeight))
        contentView.delegate = self
        contentView.contentSize = CGSizeMake(2 * kScreenWidth, kScreenHeight)
        contentView.bounces = false
        self.view.addSubview(contentView)
        
        infoTable = UITableView(frame: CGRectMake(0, 0, 2 * kScreenWidth, kScreenHeight), style: UITableViewStyle.Plain)
        infoTable.dataSource = self
        infoTable.delegate = self
        infoTable.separatorStyle = UITableViewCellSeparatorStyle.None
        infoTable.registerClass(TableViewCell.self, forCellReuseIdentifier: infoIndentifier)
        contentView.addSubview(infoTable)
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK:头部
    func configTableHeader() {
        var title = UILabel(frame: CGRectMake(0, 10, kOriginX, 30))
        title.text = "标题"
        title.textAlignment = NSTextAlignment.Center
        self.view.addSubview(title)
        
        infoRank = UIScrollView(frame: CGRectMake(kOriginX, 0, kScreenWidth - kOriginX, 40))
        
        for var i = 0; i < 7; i++ {
            var x = CGFloat(i * 50)
            var label = UILabel(frame: CGRectMake(x, 10, 50, 30))
            label.textAlignment = NSTextAlignment.Center
            label.text = "标题"
            label.font = UIFont.systemFontOfSize(12)
            infoRank.addSubview(label)
        }
        infoRank.contentSize = CGSizeMake(2*kScreenWidth, 40)
        self.view.addSubview(infoRank)
    }
    
    //MARK: tableView Datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.isEqual(titleTable) {
          var cell = tableView.dequeueReusableCellWithIdentifier(titleIndenifier, forIndexPath: indexPath) as! UITableViewCell
            if cell.isEqual(nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: titleIndenifier)
            }
            cell.textLabel!.text = "产品名称"
            if indexPath.row%2 == 1 {
                cell.backgroundColor = UIColor(white: 0.93, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.whiteColor()
            }
            return cell
        }
        var xib: NSArray = NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: self, options: nil)
        var cell = xib.objectAtIndex(0) as! TableViewCell
        cell.setWithData(indexPath.row)
        if indexPath.row%2 == 1 {
            cell.backgroundColor = UIColor(white: 0.93, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
        
    }
    //MARK: ScrollView Delegate 
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isEqual(titleTable) {
            infoTable.contentOffset.y = titleTable.contentOffset.y
        }
        if scrollView.isEqual(infoTable) {
           titleTable.contentOffset.y = infoTable.contentOffset.y
            
        }
        if scrollView.isEqual(contentView) {
            infoRank.contentOffset.x = scrollView.contentOffset.x
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let delayInSeconds = 1.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            var indexes = [indexPath]
            self.infoTable.reloadRowsAtIndexPaths(indexes, withRowAnimation: UITableViewRowAnimation.None)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

