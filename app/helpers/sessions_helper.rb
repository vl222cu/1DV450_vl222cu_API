module SessionsHelper
  def api_authenticate
    if request.headers['Authorization'].present?
      auth_header = request.headers['Authorization'].split(' ').last

      @token_payload = decodeJWT auth_header.strip
      if !@token_payload
        render json: {error: "The provided token wasn't correct."}, status: :bad_request
      end
    else
      render json: {error: 'Need to include the Authorization header.'}, status: :forbidden
    end
  end

  def encodeJWT(storyteller, exp=2.hours.from_now)
    payload = {storyteller_id: storyteller.id}
    payload[:exp] = exp.to_i

    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS512')
  end

  def decodeJWT(token)
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, 'HS512')

    if payload[0]['exp'] >= Time.now.to_i
      payload
    else
      puts 'Time fucked up'
      false
    end
    rescue => error
      puts error
      nil
  end
end