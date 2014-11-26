
runner_path = ENV['RUNNER_ROOT']
require "#{runner_path}/bin/mktest_template.rb"
require "#{runner_path}/bin/mktest_runner.rb"

def say_n_print text
	p text
	system "say #{text}"
end

def cmd_runner pathname
	say_n_print "running test for #{pathname}..."
	mktest_runner pathname
end

def cmd_creator pathname
	say_n_print "creating test template for #{pathname}..."
	mktest_template pathname
end


pathname = ARGV.first

unless pathname.include? "test"
	path, filename = File.split pathname
	extension = File.extname filename
	basename  = File.basename filename, extension 
	pathname = File.join path, "test", "test_"+basename+extension

	unless File.file? pathname
		cmd_creator pathname
	end
end

cmd_runner pathname

exit 0

