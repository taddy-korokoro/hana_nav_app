class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'date'

  def date
    Date.today.month
  end
end
