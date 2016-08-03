class ScanValidator < ActiveModel::Validator
  def validate record
    if record.event != 'deploy'
      record.errors[:event] << "Unsupported webhook event: #{record.event}"
    end

    if record.result != 'passed'
      record.errors[:result] << 'Failed CI build. Aborting.'
    end
  end
end
