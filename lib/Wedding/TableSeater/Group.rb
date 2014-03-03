require 'set'

module Wedding
  module TableSeater
    class GroupBase
      attr_accessor :id
      attr_accessor :name
      attr_accessor :members

      def initialize(options = {})
        @members = Set.new
      end

      def is_member?(person)
        @members.count(person) == 1 ? true : false
      end

      def affinity(a, b)
        raise NotImplementedError.new("You must implement affinity on GroupBase subclasses")
      end
    end

    # standard group gives a set affinity between all members
    class StandardGroup < GroupBase
      attr_accessor :affinity
      def initialize(options = {})
        super(options)
        @affinity = options[:affinity] || 0
      end

      def affinity(a, b)
        if is_member?(a) && is_member?(b)
          return @affinity
        end
        return 0
      end
    end
  end
end



