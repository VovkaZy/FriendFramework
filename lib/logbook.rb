# frozen_string_literal: false

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
require 'logger'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Logbook - configured logging utility.
#
# Created by ZUBARIEV, Volodymyr 09-19.02.2019
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# == Description
#
# The Logger module is an configured logging utility that
# used to better compose test output in our framework.
# See reporters in stdlib at http://ruby-doc.org
# for more documentation of base Logger class methods.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class Logbook
  @logger = Logger.new(STDOUT)
  @logger.level = Logger::INFO
  @logger.datetime_format = '%Y-%m-%d | %H:%M:%S | '

  # Variable for step counting
  @last_step_number = 1

  # Variables for warn/error counting
  # Used for publish results
  @warnings_count = 0
  @errors_count = 0

  # Use for test-case step message
  def self.step(message)
    @logger.unknown(" [#{@last_step_number}] #{message}:")
    @last_step_number += 1
  end

  # Use when action is completed
  def self.done(message = nil)
    self.message(message) unless message.nil?

    puts "\n"
  end

  # Use for regular message
  def self.message(message)
    @logger.info(message)
  end

  # Use for warning message
  def self.warning(message)
    @logger.warn(message)

    @warnings_count += 1
  end

  # Use for unhandleable & fatal errors
  def self.error(message, is_fatal = false)
    if is_fatal
      @logger.fatal(message)
      exit
    else
      @logger.error(message)
    end

    @errors_count += 1
  end

  # Use for publishing test execution results
  def self.publish_results
    puts '============================='
    puts 'Result of test execution >>> '
    puts '============================='
    puts " > Steps: [#{@last_step_number - 1}]"
    puts " > Warnings: [#{@warnings_count}]"
    puts " > Errors: [#{@errors_count}]"
    puts '============================='
  end
end
