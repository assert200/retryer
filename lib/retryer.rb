module Retryer
  class Retry
    attr_accessor :max_retries, :interval

    def initialize(max_retries: 5, interval: 1, verbose: true)
      @max_retries=max_retries
      @interval=interval
      @verbose=verbose
    end

    def do(description: 'Operation')
      retries = 0
      begin
        yield
      rescue Exception => e
        if retries < @max_retries
          sleep @interval
          retries += 1
          puts "Retrying: '#{description}' (retries #{retries}) with caught exeception: #{e}" if @verbose
          retry
        end
        raise "MAX RETRIES REACHED: '#{description}' failed after retrying #{@max_retries} times."
      end
    end
  end

  class Wait
    attr_accessor :timeout, :interval

    def initialize(timeout: 5, interval: 1, verbose: true)
      @timeout=timeout
      @interval=interval
      @verbose=verbose
    end

    def until(description: 'Operation')
      begin
        Timeout::timeout(@timeout) do
          retries = 0
          begin
            raise "Condition not met" unless yield
          rescue Exception => e
            sleep @interval
            retries += 1
            puts "Retrying during wait (retries #{retries}) '#{description}' with caught exeception: #{e}" if @verbose
            retry
          end
        end

      rescue Exception => e
        raise "TIMEOUT: '#{description}' after waiting #{@timeout} seconds."
      end
    end
  end
end