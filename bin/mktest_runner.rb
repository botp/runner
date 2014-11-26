#-------------------------------------
#!env ruby
#
#-------------------------------------

require 'fileutils'

def mktest_runner pathname
   dict_ext_w_runner = {
      ".py"=>"py.test -v %s",
      ".js"=>"mocha %s",
      ".rb"=>"ruby %s -v",
   }


   dirname,filename = File.split(pathname)
   extension    = File.extname(filename).downcase
 
   runner = dict_ext_w_runner[extension]
   unless runner
      print "Unrecognized file extension for #{pathname}\n"
      print "Valid file extensions are: %s" % dict_ext_w_runner.keys.join(",") 
      exit 1
   end

   cmd = runner % [pathname]
   system cmd

   # exit 0

end

if $0 == __FILE__
   pathname = ARGV[0] || raise( "syntax: %s <file_to_testrun>" % __FILE__ )
   mktest_runner pathname
end

