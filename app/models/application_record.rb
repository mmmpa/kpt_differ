class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def initialize(*)
    super

    self.hex ||= SecureRandom.hex(8)
  end
end
