//
//  UITableViewExtensions.swift
//  YYSwift
//
//  Created by Phoenix on 2018/1/8.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UITableView {
    
    /// YYSwift: Index path of last row in tableView.
    public var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }
    
    /// YYSwift: Index of last section in tableView.
    public var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
}

// MARK: - Methods
public extension UITableView {
    
    /// YYSwift: Number of all rows in all sections of tableView.
    ///
    /// - Returns: The count of all rows in the tableView.
    public func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    /// YYSwift: Perform a series of method calls that insert, delete, or select rows and
    /// sections of the receiver.
    ///
    /// - Parameter block: A block combine a series of method calls.
    public func update(with block: ((UITableView) -> Void)) {
        beginUpdates()
        block(self)
        endUpdates()
    }
    
    /// YYSwift: Scrolls the receiver until a row or section location on the screen.
    ///
    /// - Parameters:
    ///   - row: Row index in section. NSNotFound is a valid value for
    ///          scrolling to a section with zero rows.
    ///   - section: Section index in table.
    ///   - scrollPosition: A constant that identifies a relative position in the
    ///                     receiving table view (top, middle, bottom) for row when
    ///                     scrolling concludes.
    ///   - animated: true if you want to animate the change in position,
    ///               false if it should be immediate.
    public func scrollTo(row: Int,
                         inSection section: Int,
                         at scrollPosition: UITableView.ScrollPosition,
                         animated: Bool) {
        let indexPath = IndexPath(row: row, section: section)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    /// YYSwift: Insert a row at a certain indexPath with an option to animate the insertion.
    ///
    /// - Parameters:
    ///   - indexPath: A certain indexPath
    ///   - animation: A constant that either specifies the kind of animation to
    ///                perform when inserting the cell or requests no animation.
    public func insertRow(at indexPath: IndexPath,
                          with animation: UITableView.RowAnimation) {
        insertRows(at: [indexPath], with: animation)
    }
    
    /// YYSwift: Inserts a row in the receiver with an option to animate the insertion.
    ///
    /// - Parameters:
    ///   - row: Row index in section.
    ///   - section: Section index in table.
    ///   - animation: A constant that either specifies the kind of animation to
    ///                perform when inserting the cell or requests no animation.
    public func insertRow(_ row: Int,
                          inSection section: Int,
                          with animation: UITableView.RowAnimation) {
        let toInsert = IndexPath(row: row, section: section)
        self.insertRow(at: toInsert, with: animation)
    }
    
    /// YYSwift: Reloads the specified indexPath using a certain animation effect.
    ///
    /// - Parameters:
    ///   - indexPath: A certain indexPath
    ///   - animation: A constant that either specifies the kind of animation to
    ///                perform when inserting the cell or requests no animation.
    public func reloadRow(at indexPath: IndexPath,
                          with animation: UITableView.RowAnimation) {
        reloadRows(at: [indexPath], with: animation)
    }
    
    /// YYSwift: Reloads the specified row using a certain animation effect.
    ///
    /// - Parameters:
    ///   - row: Row index in section.
    ///   - section: Section index in table.
    ///   - animation: A constant that indicates how the reloading is to be animated,
    ///                for example, fade out or slide out from the bottom. The animation
    ///                constant affects the direction in which both the old and the
    ///                new rows slide. For example, if the animation constant is
    ///                UITableViewRowAnimationRight, the old rows slide out to the
    ///                right and the new cells slide in from the right.
    public func reloadRow(_ row: Int,
                          in section: Int, with animation: UITableView.RowAnimation) {
        let toReload = IndexPath(row: row, section: section)
        self.reloadRow(at: toReload, with: animation)
    }
    
    /// YYSwift: Deletes the  with an option to animate the deletion.
    ///
    /// - Parameters:
    ///   - indexPath: The indexPath.
    ///   - animation: A constant that indicates how the deletion is to be animated,
    ///                for example, fade out or slide out from the bottom.
    public func deleteRow(at indexPath: IndexPath,
                          with animation: UITableView.RowAnimation) {
        deleteRows(at: [indexPath], with: animation)
    }
    
    /// YYSwift: Deletes the row with an option to animate the deletion.
    ///
    /// - Parameters:
    ///   - row: Row index in section.
    ///   - section: Section index in table.
    ///   - animation: A constant that indicates how the deletion is to be animated,
    ///                for example, fade out or slide out from the bottom.
    public func deleteRow(_ row: Int,
                          inSection section: Int,
                          with animation: UITableView.RowAnimation) {
        let toInsert = IndexPath(row: row, section: section)
        self.deleteRow(at: toInsert, with: animation)
    }
    
    /// YYSwift: Inserts a section in the receiver, with an option to animate the insertion.
    ///
    /// - Parameters:
    ///   - section: An index specifies the section to insert in the receiving
    ///              table view. If a section already exists at the specified
    ///              index location, it is moved down one index location.
    ///   - animation: A constant that indicates how the insertion is to be animated,
    ///                for example, fade in or slide in from the left.
    public func insertSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet.init(integer: section)
        insertSections(sections, with: animation)
    }

    /// YYSwift: Deletes a section in the receiver, with an option to animate the deletion.
    ///
    /// - Parameters:
    ///   - section: An index that specifies the sections to delete from the
    ///              receiving table view. If a section exists after the specified
    ///              index location, it is moved up one index location.
    ///   - animation: A constant that either specifies the kind of animation to
    ///                perform when deleting the section or requests no animation.
    public func deleteSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet.init(integer: section)
        deleteSections(sections, with: animation)
    }
    
    /// YYSwift: Reloads the specified section using a given animation effect.
    ///
    /// - Parameters:
    ///   - section: An index identifying the section to reload.
    ///   - animation: A constant that indicates how the reloading is to be animated,
    ///                for example, fade out or slide out from the bottom. The
    ///                animation constant affects the direction in which both the
    ///                old and the new section rows slide. For example, if the
    ///                animation constant is UITableViewRowAnimationRight, the old
    ///                rows slide out to the right and the new cells slide in from the right.
    public func reloadSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet.init(integer: section)
        reloadSections(sections, with: animation)
    }
    
    /// YYSwift: IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// YYSwift: Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// YYSwift: Unselect all rows in tableView.
    ///
    /// - Parameter animated: true to animate the transition,
    ///                       false to make the transition immediate.
    public func clearSelectedRows(animated: Bool) {
        guard let indexs = indexPathsForSelectedRows else {
            return
        }
        indexs.forEach { deselectRow(at: $0, animated: animated) }
    }
    
    /// YYSwift: Remove TableFooterView.
    public func removeTableFooterView() {
        tableFooterView = nil
    }
    
    /// YYSwift: Remove TableHeaderView.
    public func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    /// YYSwift: Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name (optional value)
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }
    
    /// YYSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T
    }
    
    /// YYSwift: Dequeue reusable UITableViewHeaderFooterView using class name
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name (optional value)
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T
    }
    
    /// YYSwift: Register UITableViewHeaderFooterView using class name
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the header or footer view.
    ///   - name: UITableViewHeaderFooterView type.
    public func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// YYSwift: Register UITableViewHeaderFooterView using class name
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    public func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// YYSwift: Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    public func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    /// YYSwift: Register UITableViewCell using class name
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the tableView cell.
    ///   - name: UITableViewCell type.
    public func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
}
