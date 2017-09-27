class Sign < ApplicationRecord
  belongs_to :particle_instance, optional: true
  
  validates :relay, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  mount_uploader :picture, SignUploader
end
