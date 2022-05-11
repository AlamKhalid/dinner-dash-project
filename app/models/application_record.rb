# frozen_string_literal: true

# Base model for each class, every class inherits from this class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
