//
//  SurveyTableViewDelegate.swift
//  Pods
//
//  Created by Nora Mullaney on 3/15/17.
//
//

import Foundation

open class SurveyTableViewDelegate : NSObject, UITableViewDelegate {
   
   var surveyQuestions : SurveyQuestions
   var heightAtIndexPath: [AnyHashable : CGFloat] = [:]
   
   public init(_ surveyQuestions : SurveyQuestions) {
      self.surveyQuestions = surveyQuestions
   }
   
   open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      TableUIUpdater.updateTable(self.surveyQuestions.selectedRowAt(indexPath), tableView: tableView)
      tableView.deselectRow(at: indexPath, animated: false)
   }
   
   public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if let height = heightAtIndexPath[key(indexPath)] {
         return height
      } else {
         return UITableViewAutomaticDimension
      }
   }
   
   public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
      if let height = heightAtIndexPath[key(indexPath)] {
         return height
      } else {
         return UITableViewAutomaticDimension
      }
   }
   
   open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      let height = cell.frame.size.height
      let cellKey = key(indexPath)
      self.heightAtIndexPath[cellKey] = height
   }
   
   private func key(_ indexPath: IndexPath) -> AnyHashable {
      if self.surveyQuestions.isSubmitSection(indexPath: indexPath) {
         return "SubmitQuestion"
      }
      return self.surveyQuestions.questionPath(for: indexPath).description
   }
}
