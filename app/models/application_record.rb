# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the application.
# It inherits from ActiveRecord::Base and is used to share common model logic.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
