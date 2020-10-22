class ProccessResult
  attr_reader :message, :code

  def initialize(status, message)
    @code = status
    @message = message
  end

  def is_success
    @code >= 200 && @code < 300
  end

end
