require 'colorator'
require 'find'

# This is a makeshift integration test-suite.
# It is unapologetically pragmatic.

# Find all files in a given directory
#
def dir_files(dir)
  Find.find(dir).to_a.reject!{|f| File.directory?(f) }
end

# Recursively diff two directories
#
# This will walk through dir1 and diff matching paths in dir2
#
def compare_directories(dir1, dir2)
  dir_files(dir1).each do |file|
    file2 = file.sub(dir1, dir2)
    if File.exist?(file2)
      diff = diff_file(file, file2)
      if diff =~ /(<.+?\n)?(---\n)?(>.+)/
        @failures << {
          desc: "Diff of file: #{file} in #{dir2}",
          expected: $1,
          result: $3
        }
        pout 'F'.red
      else
        pout '.'.green
      end
    else
      @failures << {
        desc: "Diff of file: #{file} in #{dir2}",
        message: "No such file or directory: #{file2}"
      }
      pout 'F'.red
    end
  end
end

# Diff two files
#
def diff_file(file1, file2)
  diff = `diff #{file1} #{file2}`
  if diff.size > 0
    diff
  else
    false
  end
end

# Run test cases
#
# Input: options hash, format:
#   {
#     desc:   description of task
#     cmd:    system command to be run, (String or Array)
#     expect: expected output from command
#   } 
#
def test(options)
  if cmd = options[:cmd]
    cmd = [cmd] unless cmd.is_a? Array
    output = `#{cmd.join('; ')}`.gsub(/#{Dir.pwd}\/*/,'').strip
    if options[:expect].strip == output
      pout '.'.green
    else
      pout 'F'.red
      @failures << {
        desc: options[:desc],
        expected: options[:expect],
        result: output,
      }
    end
  end
end


# Print a single character without a newline
#
def pout(str)
  print str
  $stdout.flush
end

# Ouptut nicely formatted failure messages
#
def print_results
  if !@failures.empty?
    @failures.each do |test|
      puts "\nFailed: #{test[:desc]}"
      if test[:message]
        puts "  #{test[:message]}".red
      else
        puts "  #{test[:expected]}".green
        puts "  #{test[:result]}".red
      end
     # print a newline for easier reading
      puts ""
    end
    abort
  else
    puts "All passed!".green
  end
end

