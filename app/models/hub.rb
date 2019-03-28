class Hub < ApplicationRecord
  belongs_to :route, optional: true
end
