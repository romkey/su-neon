require 'particle'

class Sign < ApplicationRecord
  belongs_to :particle_instance, optional: true
  has_and_belongs_to_many :keywords

  validates :relay, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }

  def turn_on
    set_relay true
    update_attributes(lit: true)
  end

  def turn_off
    set_relay false
    update_attributes(lit: false)
  end

  private

  def set_relay(state)
    return unless particle_instance_id

    p = ParticleInstance.find particle_instance_id
    return unless p

    p.set_relay relay, state 
  end
end
