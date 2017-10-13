class ParticleInstance < ApplicationRecord
  has_many :sign

  
  # https://docs.particle.io/datasheets/particle-shields/#relay-shield-sample-code
  # curl https://api.particle.io/v1/devices/0123456789abcdef/relay -d access_token=123412341234 -d params=r1,HIGH
  def set_relay(relay, state)
    uri = URI.parse "https://api.particle.io/v1/devices/#{particle_id}/relay"
    header = { access_token: Config.first.access_token }
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = "params=r#{relay},#{state ? 'HIGH' : 'LOW' }"
    response = http.request(request)

    # -d access_token=123412341234 -d params=r1,HIGH
  end
end
