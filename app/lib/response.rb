module Response
  SUCCESS = "success"
  FAILED = "failed"

  def json_response(message, data = nil, error = nil, status = :ok)
    render json: { status: message, data: data, error: error }, status: status
  end

  def json_response_login(message, data = nil, error = nil, token = nil, status = :ok)
    render json: { status: message, data: data, error: error, token: token }, status: status
  end

  def json_response_admin(message, data = nil, error = nil, total = 0, status = :ok)
    render json: { status: message, data: data, error: error, total: total }, status: status
  end
end
