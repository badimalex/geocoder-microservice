require 'prometheus/client'
require 'prometheus/middleware/exporter'

Metrics.configure do |registry|
  registry.counter(
    :geocoding_requests_total,
    docstring: 'The total number of geocoding requests.',
    labels: %i[result]
  )
  registry.histogram(
    :service_geolocate_time,
    docstring: 'The total time of geocoding coordinates.',
    labels: %i[service]
  )
end
