class ParticleInstance < ApplicationRecord
  has_many :sign

  # https://docs.particle.io/datasheets/particle-shields/#relay-shield-sample-code
  # curl https://api.particle.io/v1/devices/0123456789abcdef/relay -d access_token=123412341234 -d params=r1,HIGH
  def set_relay(relay, state)
    return unless Config.first.particle_access_token.present?

    uri = URI.parse "https://api.particle.io/v1/devices/#{particle_id}/relay"

    header = { Authorization: "Bearer #{Config.first.particle_access_token }" }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = "params=r#{relay},#{state ? 'LOW' : 'HIGH' }"
    response = http.request(request)

    # -d access_token=123412341234 -d params=r1,HIGH
  end
end
