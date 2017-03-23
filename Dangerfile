
declared_trivial = github.pr_title.include? "#trivial"

warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

warn("Big PR") if git.lines_of_code > 500

# Check if new test implemented 

made_changes_in_tests = git.modified_files.include?("*Tests.swift")
warn("No changes in Tests") if !made_changes_in_tests


message("@barrault01 a PR to Review!!") if github.pr_author != "barrault01" 

require 'fastlane'
last_tag = Fastlane::OneOff.run(action: "last_git_tag",parameters:{})
options = {
    path: "./ChargeBack/Info.plist",
    key: "CFBundleShortVersionString"
}
version_number = Fastlane::OneOff.run(action: "get_info_plist_value", parameters: options) 

if (last_tag >= version_number)
	fail("The version number was not updated!")
else
	message("The version number is OK!") 
end

xcode_summary.report 'build/reports/errors.json'
xcodebuild.json_file = './build/reports/errors.json'


errors = xcodebuild.parse_errors 
puts "#{errors}"

warnings = xcodebuild.parse_warnings 
puts "#{errors}"



# Run SwiftLint
swiftlint.lint_files

slather.configure("ChargeBack.xcodeproj", "ChargeBack-pod", options:{
	  workspace: 'ChargeBack.xcworkspace',
  	output_directory: "./reports"
})

slather.show_coverage
