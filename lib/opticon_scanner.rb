require "logger"
require "fileutils"
#set up the logger

FileUtils.mkdir(File.dirname(__FILE__)+'/../log') unless Dir.exist?(File.dirname(__FILE__)+"/../log")

$LOG = Logger.new(File.dirname(__FILE__)+'/../log/opticon_log.log', 100, 1024**2)
$LOG.level = Logger::INFO

require "require_all"
require_rel "./"

