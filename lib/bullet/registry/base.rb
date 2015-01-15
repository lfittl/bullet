module Bullet
  module Registry
    class Base
      attr_reader :registry

      def initialize
        @registry = {}
        @callers  = {}
      end

      def [](key)
        @registry[key]
      end

      def each(&block)
        @registry.each(&block)
      end

      def delete(base)
        @registry.delete(base)
      end

      def select(*args, &block)
        @registry.select(*args, &block)
      end

      def add(key, value)
        @callers[[key, value]] = caller
        @registry[key] ||= Set.new
        if value.is_a? Array
          @registry[key] += value
        else
          @registry[key] << value
        end
      end

      def include?(key, value)
        !@registry[key].nil? && @registry[key].include?(value)
      end

      def find_caller(key, value)
        @callers[[key, value]]
      end
    end
  end
end
