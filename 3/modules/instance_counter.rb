# class counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # class methods
  module ClassMethods
    attr_reader :instances
    def increase_amount
      @instances ||= 0
      @instances += 1
    end
  end

  # instance methods
  module InstanceMethods
    protected

    def register_instance
      self.class.increase_amount
    end
  end
end
