module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.send :include, InstanceMethod
  end

  module ClassMethod
    @@instances = 0
    def instances
      @@instances
    end
  end

  module InstanceMethod
    protected
      def register_instance
        @@instances += 1
      end
  end
end
