class Bot < SlackRubyBot::Bot
  command 'sign' do |client, data, match|
    Rails.cache.write next_id, { text: match['expression'] }
    client.say(channel: data.channel, text: match['expression'])
  end

  command 'list' do |client, data, match|
    puts '>>> LIST <<<'
    client.say(channel: data.channel, text: Sign.order(name: :asc).pluck(:name))
  end

  command 'keyword' do |client, data, match|
    Rails.cache.write next_id, { text: match['expression'] }
    client.say(channel: data.channel, text: match['expression'])
  end
end
