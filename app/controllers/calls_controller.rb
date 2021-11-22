class CallsController < ApplicationController
    def search
        @artists = Artist.where("name LIKE ?", "%#{params[:keyword]}%")
    end
end
