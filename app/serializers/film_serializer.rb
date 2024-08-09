class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :publishing_year, :poster_url

  def poster_url
    
    if object.poster.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.poster, only_path: false)
    else
      nil
    end
  end
end
