module Locatable
  # handles all the locations search stuff
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    mapping do
      indexes :street_address
      indexes :city
      indexes :state
      indexes :coordinates, type: 'geo-point', lat_lon: true, normalize: false, validate: true
    end
  end
  # we actually dont have an attribut called coordinates so we will make a method

  module InstanceMethods
    def coordinates
      [latitude, longitude]
    end

    # rails has a method called as_json that will pretty much return a attributes as giant hash
    def as_indexed_json(options={})
      as_json(
        methods: [
          :coordinates,
          :address
        ]
      )
    end
  end

  # making a custom method. params we are passing is a hash
  module ClassMethods
    def search(params)
      es = __elasticsearch__
      definition = {
        query: {
          query_string: {
            query: params[:q], default_operator: 'AND'
          }
        }
      }

      # this part is not working!!
      definition.merge!({
        filter: {

            geo_distance: {
              distance: "#{params[:distance]}mi",
              'pin.location' => params[:coordinates]
            }
        }
      })

      response = es.search(definition)
      response
    end
  end

end
