class RatingsController < ApplicationController

    def index
        puts "PARAMS"
        puts params
        @user = current_user
        @ratings = Rating.where(user_id: @user.id, shelf_id: Shelf.where(user_id: @user.id, name: params["shelfName"]).first.id)
        render json: @ratings.to_json
    end

    def create
        #expected params: public_user_id, media_type, type_id, review, details
        #
        puts "Auth Passed to create"
        @user = current_user
        params[:user] = @user
        params[:user_id] = @user.id
        #take the param[isbn], and call an API to get title, cover image, author
        if params[:ratingtype] == "Wishlist"
            response = Rating.addToWishlist(@user, params[:google_id])
        else       
            response = Rating.handleRating(@user, params)
        end
        render json: response.to_json
    end

    def bookDetails
        puts "Details"
        #send back: Total ratings, text of reviews (cap at 10), review from user, total positive ratings
        
        ratings = Rating.getDetails(params["book_id"], current_user.id)
        puts ratings
        render json: ratings.to_json
    end

    private

    def rating_params
        params.permit(:media_type, :google_id, :value, :review, :ratingtype)
    end

end