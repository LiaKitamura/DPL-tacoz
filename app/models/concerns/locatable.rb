module Locatable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    # customize the index name as to not conflict with other apps using the same ES engine
    index_name "tacoz_#{Rails.env.to_s.downcase}_#{name.underscore}"

    mapping do
      indexes :street_address
      indexes :city
      indexes :state
      # using a different analyzer
      indexes :address, analyzer: 'simple'
      # using a geo point
      indexes :coordinates, type: 'geo_point', lat_lon: true, normalize: false, validate: true
    end
  end

  # ES needs this to be a string in "lat,lon" format
  def coordinates
    [latitude, longitude].join(',')
  end

  # This is the structure imported into ES
  def as_indexed_json(options={})
    as_json(
      only: [
        :street_address,
        :street_address2,
        :city,
        :state,
        :zip
      ],
      methods: [
        :coordinates,
        :address
      ]
    )
  end

  module ClassMethods
    # Override .search to allow for customization
    def search(params)
      es = __elasticsearch__
      definition = {
        query: {
          query_string: {
            query: params[:q].blank? ? '*' : params[:q],
            default_operator: 'AND'
          }
        }
      }

      if params[:coordinates] && params[:distance].present?
        definition.merge!({
          filter: {
            geo_distance: {
              distance: "#{params[:distance]}mi",
              coordinates: {
                lon: params[:coordinates][0],
                lat: params[:coordinates][1]
              }
            }
          }
        })
      end

      # return the response object
      es.search(definition)
    end
  end
end
