lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "book_hunter"
  spec.version       = "0.1"
  spec.authors       = ["Miloserdov Nikita"]
  spec.email         = ["nmiloserdov09@gmail.com"]

  spec.summary       = %q{Telegram bot}
  spec.description   = %q{Find random books for users}
  spec.homepage      = "https://github.com/nmiloserdov/book-hunter"

  # Prevent pushing this gem to RubyGems.org by setting "allowed_push_host", or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "'https://git.fury.io'"
  else
    raise "RubyGems 2.0 or newer required to protect against public gem pushes."
  end

  spec.files         = "git ls-files -z".split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  # spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rspec"
  spec.add_dependency "byebug"
  spec.add_dependency "telegram-bot-ruby"
  spec.add_dependency "activerecord"
  spec.add_dependency "pg"
  spec.add_dependency "pry"
  spec.add_dependency "colorize"
  spec.add_dependency "mechanize"
end
