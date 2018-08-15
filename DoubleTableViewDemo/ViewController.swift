//
//  ViewController.swift
//  DoubleTableViewDemo
//
//  Created by Developer on 15/6/30.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let kScreenHeight = Int(UIScreen.main.bounds.height)
    let kScreenWidth = Int(UIScreen.main.bounds.width)
    let titleIndenifier = "titleCell"
    let infoIndentifier = "infoCell"
    let kOriginX = 120
    var titleTable: UITableView!
    var infoTable: UITableView!
    var contentView: UIScrollView!
    var infoRank: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableHeader()
        titleTable = UITableView(frame: CGRect(x: 0,y: 40,width: kOriginX,height: kScreenHeight), style: UITableViewStyle.plain)
        titleTable.dataSource = self
        titleTable.delegate = self
        titleTable.rowHeight = 50
        titleTable.separatorStyle = .none
        titleTable.register(UITableViewCell.self, forCellReuseIdentifier: titleIndenifier)
        self.view.addSubview(titleTable)
        contentView = UIScrollView(frame: CGRect())
        contentView = UIScrollView(frame: CGRect(x:kOriginX, y:40,width: kScreenWidth - kOriginX,height: kScreenHeight))
        contentView.delegate = self
        contentView.contentSize = CGSize(width: 2*kScreenWidth, height: kScreenHeight)
        contentView.bounces = false
        self.view.addSubview(contentView)
        
        infoTable = UITableView(frame: CGRect(x:0,y: 0, width: 2 * kScreenWidth,height: kScreenHeight), style: UITableViewStyle.plain)
        infoTable.dataSource = self
        infoTable.delegate = self
        infoTable.separatorStyle = .none
        infoTable.rowHeight = 50
        infoTable.register(TableViewCell.self, forCellReuseIdentifier: infoIndentifier)
        contentView.addSubview(infoTable)
    }
    //MARK:头部
    func configTableHeader() {
        let title = UILabel(frame: CGRect(x: 0, y : 10, width: kOriginX, height:40))
        title.text = "标题"
        title.textAlignment = NSTextAlignment.center
        self.view.addSubview(title)
        let frame = CGRect(x: kOriginX, y: 0, width: kScreenWidth - kOriginX, height: 40)
        infoRank = UIScrollView(frame: frame)
        
        for i in 0...6 {
            let x = i * 50
            let frame = CGRect(x: x, y: 10, width: 50, height: 40)
            let label = UILabel(frame: frame)
            label.textAlignment = NSTextAlignment.center
            label.text = "标题"
            label.font = UIFont.systemFont(ofSize: 12)
            infoRank.addSubview(label)
        }
        infoRank.contentSize = CGSize(width:2*kScreenWidth, height:40)
        self.view.addSubview(infoRank)
    }
    
    //MARK: tableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.isEqual(titleTable) {
            var cell = tableView.dequeueReusableCell(withIdentifier: titleIndenifier, for: indexPath)
            if cell.isEqual(nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: titleIndenifier)
            }
            cell.textLabel!.text = "产品名称"
            if indexPath.row%2 == 1 {
                cell.backgroundColor = UIColor(white: 0.93, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.white
            }
            return cell
        }
        let xib: NSArray = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)! as NSArray
        let cell = xib.object(at: 0) as! TableViewCell
        cell.setWithData(row: indexPath.row)
        if indexPath.row%2 == 1 {
            cell.backgroundColor = UIColor(white: 0.93, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }

    //MARK: ScrollView Delegate 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
//        let delayInSeconds = 1.0
//
//        let popTime = dispatch_time(DISPATCH_TIME_NOW,
//            Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
//        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
//            var indexes = [indexPath]
//            self.infoTable.reloadRowsAtIndexPaths(indexes, withRowAnimation: UITableViewRowAnimation.None)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

