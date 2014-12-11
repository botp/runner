
runner_test_folder = ENV['RUNNER_TEST_FOLDER'] || "tests" 
runner_path = ENV['RUNNER_ROOT']

require "#{runner_path}/bin/mktest_template.rb"
require "#{runner_path}/bin/mktest_runner.rb"

def say_n_print text
	puts text
	cmd = %Q|osascript -e 'display notification "#{text}" with title "Test notification"'|
	system cmd
	# system "say '#{text}' "  # outputs audio text to speech
end

# def cmd_runner pathname
# 	# say_n_print "running test"    #  "#{File.basename(pathname)}..."
# 	say_n_print "running test #{pathname}..."
# 	# puts "running test #{pathname}..."
# 	mktest_runner pathname
# end

# def cmd_creator pathname
# 	# say_n_print "creating template"  # for #{pathname}..."
# 	say_n_print "creating template for #{pathname}..."
# 	# puts "creating template #{pathname}..."
# 	mktest_template pathname
# end


pathname = ARGV.first

unless pathname.include? "test"
	path, filename = File.split pathname
	extension = File.extname filename
	basename  = File.basename filename, extension 
	pathname = File.join path, runner_test_folder, "test_"+basename+extension

	unless File.file? pathname
		say_n_print "creating template for #{pathname}..."
		mktest_template pathname
	end
end

say_n_print "running test #{pathname}..."
runner = mktest_runner pathname
system runner

exit 0

