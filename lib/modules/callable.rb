# frozen_string_literal: true

module Callable
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def execute
    raise NotImplementedError
  end

  module ClassMethods
    def call(*args, &block)
      new(*args, &block).execute
    end
  end
end
