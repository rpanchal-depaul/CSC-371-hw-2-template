require 'open-uri'
require 'nokogiri'
require 'fileutils'
require 'Juniter'
require 'json'
require 'logger'
require 'zip'
require 'csv'
require 'optparse'

class HomeworkAssembler

    def initialize(hw_dir, hw_name, test_scheme, device)

        @logger = Logger.new(STDOUT)
        @logger.level = Logger::DEBUG

        @logger.debug("hw_dir:#{hw_dir}, hw_name:#{hw_name}, test_scheme:#{test_scheme}")

        @hw_dir = hw_dir
        @hw_name = hw_name
        @test_scheme = test_scheme
        @device = device

    end
    
    def start

        # Dir.chdir('CSC_371-HW-2-Grading')

        CSV.open("./#{@hw_name}_results.csv", "wb") do |csv|

            @logger.info("HW Dir: #{@hw_dir}")

            Dir.chdir(@hw_dir) do

                grading_key_file = File.read('./grading_key.json')
                @grading_key_dict = JSON.parse(grading_key_file)

                @logger.debug(@grading_key_dict)

                entries = Dir.entries('.').select {|entry| entry.include?(".zip") } 

                @logger.debug("#{@hw_name} Submissions: #{entries.count}")

                @logger.debug("Deleting extracted directory")

                FileUtils.rm_rf('./extracted')

                @logger.debug("extracted directory cleared")
                
                csv_header_input = ["username"]
                @grading_key_dict.keys.each do |key| 
                    
                    csv_header_input.push(key)
                end

                csv << csv_header_input

                entries.each do |entry| 

                    @logger.info("Entry: #{entry}")

                    if File.file?(entry)

                        result = process_entry(entry, @device)

                        if result.nil?
                            
                        else

                            csv_input = [
                                result["student_name"]
                            ]

                            results = result["results"]

                            @grading_key_dict.keys.each do |key| 

                                @logger.debug("key:#{key} fetched result of: #{results[key]}")
                                if results[key] == :pass
                                    csv_input.push(@grading_key_dict[key])
                                else
                                    csv_input.push(0)
                                end

                            end

                            @logger.debug("grade csv input: #{csv_input}")

                            csv << csv_input
                        end
                    end
                        
                    FileUtils.rm_rf('./extracted')

                end
            end
        end
    end

    def extract_zip(file, destination)
        FileUtils.mkdir_p(destination)

        @logger.debug("Stripping __MACOSX directories")
        output = %x|zip -d "#{file}" __MACOSX/\*|
        @logger.debug("Stripped __MACOSX directories")
        
        @logger.debug("Directory #{destination} created")
        
        @logger.debug("Opening file: #{file}")
        Zip::File.open(file) do |zip_file|
            zip_file.each do |f|
            fpath = File.join(destination, f.name)
            zip_file.extract(f, fpath) unless File.exist?(fpath)
            end
        end
    end

    # Takes an unzipped student submission, executes a build and tests it
    def process_entry(entry, device)
        # Unzip file
        extract_zip(entry, 'extracted')

        student_name = nil
        results = {}

        # Find the directory in the extracted directory where the .xcodeproj file is located.

        folder_path = Dir.glob("./extracted/**/#{@hw_name}.xcodeproj")

        if folder_path.empty?

            @logger.error("Could not find #{@hw_name}.xcodeproj for entry: #{entry}")

            return nil
        else

            @logger.info("Found folder path at: #{folder_path}")

            # Find user from bundle identifier

            @logger.debug(folder_path)
            folder_path = folder_path.first
            folder_path.slice! "#{@hw_name}.xcodeproj"

            @logger.debug("folder_path: #{folder_path}")

            Dir.chdir(folder_path) do

                bundle_identifier = %x|xcodebuild -showBuildSettings -project #{@hw_name}.xcodeproj \| grep PRODUCT_BUNDLE_IDENTIFIER \| awk -F ' = ' '{print $2}'|

                @logger.info(bundle_identifier)

                split_bundle_identifier = bundle_identifier.split('.')

                @logger.debug("split_bundle_identifier: #{split_bundle_identifier}")

                student_name = split_bundle_identifier[1].strip
                result_path = "./#{student_name}.xcresult"
                @logger.debug(result_path)

                FileUtils.rm_rf(result_path)

                test_output = %x|xcodebuild test -parallel-testing-enabled NO -project #{@hw_name}.xcodeproj -scheme #{@test_scheme} -destination '#{device}' \| xcpretty --report junit|

                # puts Dir.children('./build/reports')

                Dir.chdir('./build/reports/') do

                    xml_str = "./junit.xml"

                    @logger.debug("finding junit file")

                    doc = Juniter.from_file("junit.xml")

                    @logger.debug("found junit file: #{doc.test_suites.test_suites}")
                    
                    doc.test_suites.test_suites.each do |test_suite|

                        @logger.info(test_suite.name)

                        test_suite_tests = []

                        test_suite_results = test_suite.test_cases.map do |test_case|

                            @logger.info("test_case: #{test_case.name} with result:#{test_case.result.status}")
                           
                            results[test_case.name] = test_case.result.status
                            
                        end

                        test_suite_result = {
                            "name" => test_suite.name,
                            "tests" => test_suite_results
                        }

                        # results[test_suite.name] = test_suite_result

                    end # Test Suite processing
                end # Dir.chdir('./build/reports/')
            end # Dir.chdir(folder_path) do
        end

        return {
            "student_name" => student_name,
            "results" => results
        }
    end
end


options = {}

OptionParser.new do |opts|
    opts.banner = "Usage: grader.rb [options]"

    opts.on("-d", "--directory DIRECTORY", "Which directory") do |d|

        options[:directory] = d
    end

    opts.on("-a", "--assignment ASSIGNMENT", "Which assignment") do |a|

        options[:assignment] = a
    end
  
    opts.on("-s", "--scheme SCHEME", "Which scheme") do |s|

        options[:scheme] = s
    end    

    opts.on("-t", "--device DEVICE", "Which device target") do |t|

        options[:device] = t
    end    
end.parse!

homework_assembler = HomeworkAssembler.new(options[:directory], options[:assignment], options[:scheme], options[:device])
homework_assembler.start