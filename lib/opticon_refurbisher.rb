require_relative './opticon'

class OpticonRefurbisher
  class << self
    def run_all(name, clear_memory = false)
      threads = []
      Opticon.search
      Opticon.each do
        threads << Thread.new do
          $LOG.info("[#{__FILE__.split(?/).last}] Running refurb #{name} on #{self[:serial_number]}")
          run :clear_memory if clear_memory
          run_batch &OpticonRefurbs[name]
          $LOG.info("[#{__FILE__.split(?/).last}] Finished running refurb #{name} on #{self[:serial_number]}")
        end
      end

      while threads.any?(&:status)
        sleep(1)
      end

      threads.each(&:join)
      true
    end

    def run_on(opticon, name, clear_memory = false)
      $LOG.info("[#{__FILE__.split(?/).last}] Running refurb #{name} on #{opticon[:serial_number]}")
      opticon.run :clear_memory if clear_memory
      opticon.run_batch &OpticonRefurbs[name]
      $LOG.info("[#{__FILE__.split(?/).last}] Finished running refurb #{name} on #{opticon[:serial_number]}")

    end

    def run_on_sn(serial, name, clear_memory = false)
      opticon = Opticon[serial]
      fail unless opticon
      $LOG.info("[#{__FILE__.split(?/).last}] Running refurb #{name} on #{opticon[:serial_number]}")
      opticon.run :clear_memory if clear_memory
      opticon.run_batch &OpticonRefurbs[name]
      $LOG.info("[#{__FILE__.split(?/).last}] Finished running refurb #{name} on #{opticon[:serial_number]}")
    end
  end
end

# Put this last because opticonRefurbisher needs to be around for this.
