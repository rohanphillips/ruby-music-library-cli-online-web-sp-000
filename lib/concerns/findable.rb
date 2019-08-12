module Findable
    module ClassMethods
      def find_by_name(name)
        all.detect{|a| a.name == name}
      end

      def song_exists?(collection, song)
        collection.detect{|n| n == song}
      end
    end
end
