class Scan < ApplicationRecord
  validates_with ScanValidator
  after_save :perform

  def perform
    OptimizationWorker.perform_async(commit)
  end
end
