//
//  UITableViewExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }
    
    public var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
}


public extension UITableView {
    
    public func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    public func update(with block: ((UITableView) -> Void)) {
        beginUpdates()
        block(self)
        endUpdates()
    }
    
    public func scrollTo(row: Int, inSection section: Int, at scrollPosition: UITableViewScrollPosition, animated: Bool) {
        let indexPath = IndexPath(row: row, section: section)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    public func insertRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation) {
        insertRows(at: [indexPath], with: animation)
    }
    
    public func insertRow(_ row: Int, inSection section: Int, with animation: UITableViewRowAnimation) {
        let toInsert = IndexPath(row: row, section: section)
        self.insertRow(at: toInsert, with: animation)
    }
    
    public func reloadRowAtIndexPath(_ indexPath: IndexPath, with animation: UITableViewRowAnimation) {
        reloadRows(at: [indexPath], with: animation)
    }
    
    public func reloadRow(_ row: Int, section: Int, with animation: UITableViewRowAnimation) {
        let toReload = IndexPath(row: row, section: section)
        self.reloadRowAtIndexPath(toReload, with: animation)
    }
    
    public func deleteRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation) {
        deleteRows(at: [indexPath], with: animation)
    }
    
    public func deleteRow(_ row: Int, inSection section: Int, with animation: UITableViewRowAnimation) {
        let toInsert = IndexPath(row: row, section: section)
        self.deleteRow(at: toInsert, with: animation)
    }
    
    public func insertSection(_ section: Int, with animation: UITableViewRowAnimation) {
        let sections = IndexSet.init(integer: section)
        insertSections(sections, with: animation)
    }

    public func deleteSection(_ section: Int, with animation: UITableViewRowAnimation) {
        let sections = IndexSet.init(integer: section)
        deleteSections(sections, with: animation)
    }
    
    public func reloadSection(_ section: Int, with animation: UITableViewRowAnimation) {
        let sections = IndexSet.init(integer: section)
        reloadSections(sections, with: animation)
    }
    
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    public func clearSelectedRows(animated: Bool) {
        guard let indexs = indexPathsForSelectedRows else {
            return
        }
        indexs.forEach { deselectRow(at: $0, animated: animated) }
    }
    
    public func removeTableFooterView() {
        tableFooterView = nil
    }
    
    public func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T
    }
    
    public func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    public func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    public func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    public func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
}
