module TestBench
  def self.activate receiver=nil
    receiver ||= TOPLEVEL_BINDING.receiver

    receiver.extend TestBench.mod
  end

  def self.mod
    if Settings.toplevel.bootstrap
      require 'test_bench/bootstrap'
      TestBench::Bootstrap
    else
      self
    end
  end

  def self.runner
    mod.const_get :Runner
  end

  Settings::Environment.(Settings.toplevel)

  include Structure

  Telemetry.toplevel.output = Output.build
end
