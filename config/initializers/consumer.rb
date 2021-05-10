channel = RabbitMq.consumer_channel

queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, prop, payload|
  payload = JSON(payload)
  coordinates = Geocoder.geocode(payload['city'])

  if coordinates.present?
    client = AdsService::Client.new
    client.update_coordinates(payload['id'], coordinates)
  end

  # todo
  channel.ack(delivery_info.delivery_tag)
end
