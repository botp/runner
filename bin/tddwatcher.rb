# tddwatcher.rb

runner_test_path = ENV['RUNNER_ROOT']

require "#{runner_test_path}/bin/mktest_template.rb"
require "#{runner_test_path}/bin/mktest_runner.rb"

PARAMS = {
	test_folder: ENV['RUNNER_TEST_FOLDER'] || "./tests"  ,
	root_path:   ENV['RUNNER_ROOT'] || "/.runner"   ,
	filename_prefix: "test_"  ,
	filename_suffix: ""  ,
}

def say_n_print text
	puts text
	cmd = %Q|osascript -e 'display notification "#{text}" with title "Test notification"'|
	system cmd
	# system "say '#{text}' "  # outputs audio text to speech
end


class TestRunner
	def initialize pparams={pathname: ARGV.first}, params = PARAMS

		params.merge! pparams
		params.each do |key, value|
			self.instance_variable_set("@#{key}".to_sym, value)
		end
	end

	def is_test_file?
		@pathname.include? "test"
	end

	def testfilenamefix filename
		extension = File.extname filename
		basename  = File.basename filename, extension
		[@filename_prefix, basename, extension, @filename_suffix].join
	end

	def run
		pathname = @pathname
		unless is_test_file?
			path, filename = File.split @pathname
			pathname = File.join path, @test_folder, testfilenamefix(filename)

			unless File.file? pathname
				say_n_print "creating template for #{pathname}..."
				mktest_template pathname
			end
		end

		say_n_print "running test #{pathname}..."
		runner = mktest_runner pathname
		system runner
	end
end


TestRunner.new.run
exit 0

