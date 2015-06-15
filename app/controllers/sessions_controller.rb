class SessionsController < ApplicationController
  ## This is called from a client who wish to authenticate and get a JSON Web Token back
   def api_auth  
     creator = Creator.find_by(email: params[:email].downcase)
     if creator && creator.authenticate(params[:password])
       render json: { auth_token: encodeJWT(creator), creator: creator }
      else
        render json: { error: 'Invalid username or password' }, status: :unauthorized
      end
  end
end
