module PayloadFormater
  def response_structure(status: 200, msg: 'success', payload: {})
    {
      meta: {
        status:,
        msg:
      },
      payload:
    }.to_json
  end

  def get_payload(payload)
    response_structure(payload:)
  end

  def get_error(msg, status: 500)
    response_structure(status:, msg:)
  end

  def render_payload(payload)
    render json: get_payload(payload), status: :ok
  end

  def render_error(msg, status: 500)
    render json: get_error(msg, status:), status:
  end
end
