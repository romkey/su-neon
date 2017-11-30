require 'pp'

class RelayController < ApplicationController
  def activate
    p = params.require([:id, :state, :particle_instances_id])

    pp p

    particle = ParticleInstance.find p[2].to_i
    particle.set_relay(p[0].to_i, p[1].to_i)

    redirect_to "/particle_instances/#{p[2]}"
  end
end
