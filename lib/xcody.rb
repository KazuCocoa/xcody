require "xcody/version"
require "pathname"
require "fileutils"
require "open3"

class Xcody
  attr_reader :xcode_build_cmd

  def initialize
    xcode = `xcode-select -v`
    fail "Should install xcode commands from Apple Developer Center." if xcode.include?("command not found")
    @xcode_build_cmd = []
  end

  def xcode_build
    @xcode_build_cmd.push(Pathname.new(xcode_path).join("Contents", "Developer", "usr", "bin", "xcodebuild").to_s)
    self
  end

  def project(project_path)
    case File.extname(project_path)
    when ".xcodeproj"
      @xcode_build_cmd.push("-project", project_path)
    when ".xcworkspace"
      @xcode_build_cmd.push("-workspace", project_path)
    else
      fail "#{project_path} has no project."
    end
    self
  end

  def target(name)
    @xcode_build_cmd.push("-target", name)
    self
  end

  def alltargets
    @xcode_build_cmd.push("-alltargets")
    self
  end

  def arch(architecture)
    @xcode_build_cmd.push("-arch", architecture)
    self
  end

  def scheme(scheme)
    @xcode_build_cmd.push("-scheme", scheme)
    self
  end

  def sdk(sdk_name)
    @xcode_build_cmd.push("-sdk", sdk_name)
    self
  end

  def destination(destination)
    @xcode_build_cmd.push("-destination", destination)
    self
  end

  def configuration(config)
    @xcode_build_cmd.push("-configuration", config)
    self
  end

  def derive_data_path(data_path)
    @xcode_build_cmd.push("-derivedDataPath", data_path)
    self
  end

  def result_bundle_path(path)
    @xcode_build_cmd.push("-resultBundlePath", path)
    self
  end

  def export_archive
    @xcode_build_cmd.push("-exportArchive")
    self
  end

  def export_format(format)
    @xcode_build_cmd.push("-exportFormat", format)
    self
  end

  def archive_path(xcarchivepath)
    @xcode_build_cmd.push("-archivePath", xcarchivepath)
    self
  end

  def export_path(destinationpath)
    @xcode_build_cmd.push("-exportPath", destinationpath)
    self
  end

  def export_provisioning_profile(profilename)
    @xcode_build_cmd.push("-exportProvisioningProfile", profilename)
    self
  end

  def export_signing_identity(identityname)
    @xcode_build_cmd.push("-exportSigningIdentity", identityname)
    self
  end

  def export_installer_identity(identityname)
    @xcode_build_cmd.push("-exportInstallerIdentity", identityname)
    self
  end

  def exportWith_original_signing_identity
    @xcode_build_cmd.push("-exportWithOriginalSigningIdentity")
    self
  end

  def skip_unavailable_actions
    @xcode_build_cmd.push("-skipUnavailableActions")
    self
  end

  def xcconfig(filename)
    @xcode_build_cmd.push("-xcconfig", filename)
    self
  end

  # Build actions

  def clean
    @xcode_build_cmd.push("clean")
    self
  end

  def analyze
    @xcode_build_cmd.push("analyze")
    self
  end

  def archive
    @xcode_build_cmd.push("archive")
    self
  end

  def external_attributes(attributes)
    @xcode_build_cmd.push(attributes)
  end

  def test
    @xcode_build_cmd.push("test")
    self
  end

  def installsrc
    @xcode_build_cmd.push("installsrc")
    self
  end

  def install
    @xcode_build_cmd.push("install")
    self
  end

  # @return [String] xcode build command
  def build
    @xcode_build_cmd.push("build")
    self
  end

  def clear_cmd
    @xcode_build_cmd = []
  end

  def command
    @xcode_build_cmd.join(" ")
  end

  def run(log_file = "./tmp/build_log.txt", verb = false)
    cmd = command
    puts "running with #{cmd.inspect}"

    run_command cmd, log_file, verb
  end

  def xcpretty(log_file = "./tmp/build_log.txt", option = [], verb = false)
    cmd = command.concat(%( | xcpretty )).concat(option.join(" "))
    puts "running with #{cmd}"

    run_command cmd, log_file, verb
  end

  private

  def xcode_path
    `xcode-select -p 2> /dev/null`.strip.sub(%r{/Contents/Developer\z}, "")
  end

  def run_command(command, log_file, verb = false)
    log_file_dir = Pathname.new(log_file).dirname
    FileUtils.mkdir_p(log_file_dir)

    out_with_err, status = Open3.capture2e command

    puts out_with_err if verb

    exit_code = status.exitstatus
    case exit_code
    when 0
      File.write(log_file, out_with_err)
      puts "Build finished. Logfile is in #{log_file}"
    else
      File.write(log_file, out_with_err)
      puts "Exit build with error status: #{exit_code}"
    end
  end
end
