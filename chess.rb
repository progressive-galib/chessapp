
require 'glimmer-dsl-swt'
require 'time'


class Chess
  include Glimmer::UI::CustomShell
  
  attr_accessor :start_time ,:time_string 
  
  before_body do
    @start_time = Time.now  
    @time_string = "x"
  end

  after_body {
      Thread.new {
        loop {
          sleep(1)
          sync_exec {
            # Calculate elapsed time directly from the start time
            elapsed_time = Time.now - @start_time
        
            # Convert elapsed time to hours, minutes, and seconds
            hours = elapsed_time / 3600
            minutes = (elapsed_time % 3600) / 60
            seconds = (elapsed_time % 60).round
        
            # Format the time string with leading zeros
            self.time_string = "Time passed %02d:%02d:%02d" % [hours, minutes, seconds]
            print "\r#{time_string}"
            }
        }
      }
    }
  
  body {
    shell {
        text 'Chess'
        sash_form (:vertical) {
          size 475, 500
          orientation:vertical
          browser {
          url 'https://chess.com/'
          }
          label {
            text <=> [self, :time_string]
            background :red
            foreground :white
            font height: 20
          }
          #weights 1, 1
        }
      }
    
  }
end


