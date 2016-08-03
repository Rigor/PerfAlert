class ScanValidator < ActiveModel::Validator
  def validate record
    if record.event != 'deploy'
      record.errors[:event] << "Unsupported webhook event: #{record.event}"
    end

    if record.result != 'passed'
      record.errors[:result] << 'Failed CI build. Aborting.'
    end

    # if !!server_regex && !server_regex.match(record.server_name)
    #   record.errors[:server_name] << "Server #{record.server_name} doesn't match regex. Quitting."
    # end
  end

  # def server_regex
  #   Rails.application.config.server_regex
  # end
end
