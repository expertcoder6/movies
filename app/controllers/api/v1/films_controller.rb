module Api
  module V1
    class FilmsController < ApplicationController
      before_action :authenticate_request
      before_action :set_movie, only: [:update, :show]

      def index
        @films = Film.paginate(page: params[:page], per_page: 8)
        render json: {
          films: ActiveModelSerializers::SerializableResource.new(@films, each_serializer: FilmSerializer),
          meta: {
            total_pages: @films.total_pages,
            current_page: @films.current_page,
            next_page: @films.next_page,
            previous_page: @films.previous_page
          }
        }, status: :ok
      end

      def show
         render json: @film, serializer: FilmSerializer, status: :ok
      end

      def create
        @film = Film.new(film_params)
        if @film.save
          render json: @film, status: :ok
        else
          render json: { errors: @film.errors.full_messages }, status: 400
        end
      end

      def update
        if @film.update(film_params)
          render json: @film, status: :ok
        else
          render json: { errors: @film.errors.full_messages }, status: 400
        end
      end

      def getdata
        @films = Film.paginate(page: params[:page], per_page: 8)
        render json: {
          films: ActiveModelSerializers::SerializableResource.new(@films, each_serializer: FilmSerializer),
          meta: {
            total_pages: @films.total_pages,
            current_page: @films.current_page,
            next_page: @films.next_page,
            previous_page: @films.previous_page
          }
        }, status: :ok
      end

      private

      def set_movie
        @film = Film.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Film not found" }, status: :not_found
      end

      def film_params
        params.require(:film).permit(:title, :publishing_year, :poster)
      end
    end
  end
end
