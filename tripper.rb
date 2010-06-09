module Tripper
  protected
    ACCESS = "Access Code"
    TOKEN = "Insert Token to play :-)"
  
    def nicetripper
      @nicetripper || Nicetripper::Client.new(ACCESS,TOKEN)
    end

end