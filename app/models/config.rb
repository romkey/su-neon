class Config < ApplicationRecord
  def scrubbed_particle_access_token
    if particle_access_token.present?
      particle_access_token[0..3] + '*****' + particle_access_token[-4..-1]
    else
      "not set"
    end
  end
end
