require 'particle'

class Sign < ApplicationRecord
  belongs_to :particle_instance, optional: true
  has_and_belongs_to_many :keywords

  validates :relay, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }

  def turn_on
    set_relay
    update_attributes(lit: true)
  end

  def turn_off
    set_relay
    update_attributes(lit: false)
  end

  private
  def set_relay
#    Particle.access_token = Config.first.particle_access_token

#    device = Particle.device(particle_instance.particle_id)
    # we want to set r1, r2, r3 or r4 to LOW for off and HIGH for on
    # https://docs.particle.io/datasheets/particle-shields/#relay-shield-sample-code
#    device.function('digitalWrite', )
  end
end
