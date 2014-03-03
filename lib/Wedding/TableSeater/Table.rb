require 'set'

module Wedding
  module TableSeater
    class TableBase
      attr_accessor :id
      attr_accessor :name
      attr_accessor :max_size

      def initialize(options = {})
        @max_size = options[:max_size]
      end

      def is_full?
        raise NotImplementedError.new("You must implement is_full? on TableBase subclasses")
      end

      def calculate_benefit
        raise NotImplementedError.new("You must implement calculate_benefit on TableBase subclasses")
      end
    end

    # a standard table is order-independant, so there is only affinity between members of the table
    # Use this class when you are just assigning tables, and not exact seating order
    class StandardTable < TableBase
      attr_accessor :members

      def initialize(options = {})
        super(options)
        @members = Set.new
      end

      def is_full?
        return true if @members.count >= @max_size
        return false
      end

      def calculate_benefit
        net_benefit = 0
        @members.each do |m|
          @members.each do |o|
            next if m == o
            net_benefit += m.get_affinity_to_person(o)
          end
        end
        return net_benefit
      end
    end

    # A RoundTable seats members in a specific order taking into account their
    # affinity with their tablemates *and* their neighbors.  Round tables mean
    # each member has 2 neighbors and the 1st member is also a neighbor of the
    # last person (it wraps around)
    class RoundTable < TableBase
      attr_accessor :members

      def initialize(options = {})
        @members = []
      end

      def is_full?
        return true if @members.count >= @max_size
        return false
      end

      def calculate_benefit
        net_benefit = 0
        @members.each do |m|
          @members.each do |o|
            next if m == o
            net_benefit += m.get_affinity_to_person(o)
          end
        end
        return net_benefit
      end
    end
    class RoundTable
      attr_accessor
