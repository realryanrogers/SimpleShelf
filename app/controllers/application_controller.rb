class ApplicationController < ActionController::API
  #skip_before_action :verify_authenticity_token
  include ActionController::MimeResponds

  before_action :authenticate, except: [:fallback_index_html]

  rescue_from ResetPasswordError, with: :not_authorized

    def fallback_index_html
      puts "fallback to HTML"
      respond_to do |format|
        puts "fallback to HTML"
        format.html { render body: Rails.root.join('public/index.html').read }
      end
    end

  def logged_in?
    puts "checking current_user"
    !!current_user
  end

  def current_user
    if auth_present?
      puts "Auth present"
      puts "auth user" + auth
      user = User.find_by(public_user_id: auth)
      puts "User " + user.public_user_id
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    puts "Params"
    puts params
    puts request.env["HTTP-AUTHORIZATION"]
     if logged_in?
     else
       render json: {error: "Unauthorized"}, status: 401
     end
  end

  private

    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end

    def token

      request.headers["HTTP-AUTHORIZATION"].scan(/Bearer(.*)$/).flatten.last.strip
    end

    def auth
      puts "TOKEN " + token
      Auth.decode(token)
    end

    def auth_present?
      puts "Checking auth"
      puts request.headers.fetch("HTTP-AUTHORIZATION", "")
      !!request.headers.fetch("HTTP-AUTHORIZATION", "").scan(/Bearer/).flatten.first
    end


end
