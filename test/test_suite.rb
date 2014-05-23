require 'colorator'
require 'find'

# This is a makeshift integration test-suite.
# It is unapologetically pragmatic.


# Build Jekyll
#
def build(options={})
  if options[:octopress_config]
    FileUtils.cp options[:octopress_config], '_octopress.yml'
  end

  config = ['_config.yml'] << options[:config]
  cmd = "rm -rf site && bundle exec jekyll build --config #{config.join(',')}"

  `#{cmd}`
  `rm _octopress.yml` if options[:octopress_config]
end


# Find all files in a given directory
#
def dir_files(dir)
  Find.find(dir).to_a.reject!{|f| File.directory?(f) }
end

# Recursively diff two directories
#
# This will walk through dir1 and diff matching paths in dir2
#
def test_dirs(desc, dir1, dir2)

  test_missing_files(desc, dir1, dir2)

  dir_files(dir1).each do |file|
    file2 = file.sub(dir1, dir2)
    if File.exist?(file2)
      if diff = diff_file(file, file2)
        @failures << {
          desc: "#{desc}\nDiff of file: #{file.sub(dir1+'/', '')}\n",
          result: format_diff(diff)
        }
        pout 'F'.red
      else
        pout '.'.green
      end
    end
  end
end

def format_diff(diff)
  "#{diff.gsub(/\A.+?\n/,'').gsub(/^[^><].+/,'---').gsub(/^>.+/){|m| 
    m.green
  }.gsub(/^(<.+?)$/){ |m| 
    m.red
  }}"
end

# List differences between files in two directories
#
def test_missing_files(desc, dir1, dir2)
  files1 = dir_files(dir1).map {|f| f.sub(dir1,'') }
  files2 = dir_files(dir2).map {|f| f.sub(dir2,'') }

  missing = []

  (files2 - files1).each do |file|
    missing << File.join(dir1, file)
  end

  (files1 - files2).each do |file|
    missing << File.join(dir2, file)
  end

  if !missing.empty?
    @failures << {
      desc: "#{desc}\nMissing files:\n",
      result: " - " + missing.join("\n - ")
    }

    pout 'F'.red
  else
    pout '.'.green
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

# Test command output
#
# Input: options hash, format:
#   {
#     desc:   description of task
#     cmd:    system command to be run, (String or Array)
#     expect: expected output from command
#   } 
#
def test_cmd(options)
  if cmd = options[:cmd]
    cmd = [cmd] unless cmd.is_a? Array

    # In debug mode command output is printed
    #
    if options[:debug]
      system cmd.join('; ')
    else
      output = `#{cmd.join('; ')}`.gsub(/#{Dir.pwd}\/*/,'').strip

      # Remove character color codes
      output = output.gsub("\e",'').gsub(/\[\d+m/,'').gsub("\[0m",'')
    end
    if options[:expect] && options[:expect].strip == output
      pout '.'.green
    else
      pout 'F'.red
      @failures << {
        desc: options[:desc]+"\n",
        result: <<-HERE
expected: #{(options[:expect] || '').strip.green}
result: #{(output || '').strip.red}
HERE
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
      pout "\nFailed: #{test[:desc]}"
      puts test[:result]
      # print a newline for easier reading
      puts ""
    end
    abort
  else
    puts "All passed!".green
  end
end

