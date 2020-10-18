class ProccessResult
  attr_reader :message

  def initialize(status, message)
    @status = status
    @message = message
  end

  def is_success
    @status >= 200 && @status < 300
  end

end
