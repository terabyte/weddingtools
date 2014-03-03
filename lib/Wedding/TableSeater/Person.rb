
module Wedding
  module TableSeater
    class PersonBase
      attr_accessor :id
      attr_accessor :name
      attr_accessor :group_list

      def initialize(options = {})
      end

      def get_affinity_to_person(other)
        raise NotImplementedError.new("You must implement get_affinity_to_person() in PersonBase subclasses")
      end
    end

    class StandardPerson < PersonBase
      attr_accessor :affinity_hash

      def initialize(options = {})
        super(options)
        @affinity_hash = options[:affinity_hash] || {}
      end

      def get_affinity_to_person(other)
        if !@affinity_hash[other].nil?
          return @affinity_hash[other]
        end
        return 0
      end
    end
  end
end
