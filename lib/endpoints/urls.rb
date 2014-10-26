module Endpoints
  class Urls < Base
    namespace "/urls" do
      before do
        content_type :json, charset: 'utf-8'
      end

      get do
        MultiJson.encode Url.all.map { |x| serialize(x) }
      end

      post do
        # warning: not safe
        url = Url.new(body_params)
        url.save
        status 201
        MultiJson.encode serialize(url)
      end

      get "/:id" do |id|
        url = Url.first(uuid: id) || halt(404)
        MultiJson.encode serialize(url)
      end

      patch "/:id" do |id|
        url = Url.first(uuid: id) || halt(404)
        # warning: not safe
        #url.update(body_params)
        MultiJson.encode serialize(url)
      end

      delete "/:id" do |id|
        url = Url.first(uuid: id) || halt(404)
        url.destroy
        MultiJson.encode serialize(url)
      end

      private

      def serialize(data)
        {
          created_at: data.created_at.try(:iso8601),
          id:         data.uuid,
          updated_at: data.updated_at.try(:iso8601),
          title:      data.title,
          url:        data.url
        }
      end
    end
  end
end
