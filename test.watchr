ENV["WATCHR"] = "1"
system 'clear'

if __FILE__ == $0
  puts "Run with: watchr #{__FILE__}. \n\nRequired gems: watchr rev"
  exit 1
end

# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------

def run(cmd)
  puts(cmd)
  system(cmd)
end

def run_all_specs
  system('clear')
  run "rspec ./spec"
end

def run_single_spec *spec
  system('clear')
  spec = spec.join(' ')
  run "rspec #{spec}"
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '^spec/spec_helper\.rb'        ) {     run_all_specs }
watch( '^lib/rspec/matchers/dm/(.*)\.rb' ) { |m| run_single_spec("spec/dm/%s_spec.rb" % m[1])}
watch( '^spec/.*_spec\.rb'       ) { |m| run_single_spec(m[0]) }

 
# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_specs
end
 
# Ctrl-C
Signal.trap('INT') { abort("\n") }

#puts "Watching.."