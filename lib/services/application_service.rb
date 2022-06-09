class ApplicationService
  class ParamError < StandardError; end

  def self.call(...)
    new(...).call
  end
end
