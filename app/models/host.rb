class Host < ApplicationRecord
  has_many :rooms, dependent: :destroy
end
