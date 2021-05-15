require 'benchmark'

channel = RabbitMq.consumer_channel

queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, prop, payload|
  Thread.current[:request_id] = prop.headers['request_id']
  payload = JSON(payload)
  coordinates = Geocoder.geocode(payload['city'])

  Application.logger.info(
    'geocoded coordinates',
    city: payload['city'],
    coordinates: coordinates
  )

  if coordinates.present?
    Metrics.geocoding_requests_total.increment(labels: { result: 'success' })
    client = AdsService::Client.new

    Metrics.service_geolocate_time.observe(
      Benchmark.realtime { client.update_coordinates(payload['id'], coordinates) },
      labels: { service: 'geolocate' }
    )
  else
    Metrics.geocoding_requests_total.increment(labels: { result: 'failure' })
  end

  # todo
  channel.ack(delivery_info.delivery_tag)
end
