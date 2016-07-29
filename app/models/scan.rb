class Scan < ApplicationRecord
  validates_with ScanValidator
  after_save :perform

  def perform
    ZoompfWorker.perform_async(commit)
  end
end
