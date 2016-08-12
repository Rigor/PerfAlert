class Scan < ApplicationRecord
  include CommitFormatter
  validates_with ScanValidator
  after_save :perform

  def perform
    OptimizationWorker.perform_async(format_commit(commit))
  end
end
