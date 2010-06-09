require 'httparty'
require 'tripper'

include Tripper

module Nicetripper
  
  class Client
    include HTTParty
    base_uri 'www.nicetripper.com/api'
  
    def initialize(access=nil,token=nil)
      @auth = {:access => access || 'a', :token => token || 'b'}
    end
  
    def places(which=:friends, options={})
      array = self.class.get("/places", :query => @auth)
      array.collect{ |p| Record.new(:data => p) }  
    end
  
    def place(where='', options={})
      json = self.class.get("/places/#{where}", :query => @auth)
      Record.new(:data => json)
    end
    
    def country(where='', options={})
      json = self.class.get("/countries/#{where}", :query => @auth)
      Record.new(:data => json)
    end      
    
    def search(options={})
      array = self.class.get("/search", :query => @auth.merge(options))
      array.collect{ |p| Record.new(:data => p) }  
    end    

  end
      
  class Record
    attr_accessor :data
    attr_accessor :type
    
    def initialize(options={})
      self.data = options[:data]
    end    
    
    protected
      def method_missing(selector, *args)
        if data = self.data[selector.to_s]
          if data.is_a? Hash
            data = Record.new(:data => data)
          end
          data
        else
          super(selector, *args)
        end
      end    
  end
  
end