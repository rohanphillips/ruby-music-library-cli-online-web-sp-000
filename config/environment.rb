require 'bundler'
Bundler.require

module Concerns
  module Findable
    def find_or_create_by_name(name)
      newsong = self.find_by_name(name)
      if newsong == nil
        newsong = self.create(name)
      end
      newsong
    end
  end
end

require_all 'lib'
