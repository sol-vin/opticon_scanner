class OpticonRefurbs
  @refurbs = {}
  class << self
    def add(name, &block)
      @refurbs[name] = block
      $LOG.debug("Added Refurb #{name}")
    end

    def [] tag
      @refurbs[tag]
    end

    def each &block
      @refurbs.each &block
    end

    def keys
      @refurbs.keys
    end
  end
end

require_rel '../refurbs'