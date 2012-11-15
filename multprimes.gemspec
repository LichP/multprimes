require "./lib/mult_primes/version"

Gem::Specification.new do |s|
  s.name = "multprimes"
  s.version = MultPrimes::VERSION
  s.summary = %{A program for generating multiplication tables of prime numbers}
  s.authors = ["Phil Stewart"]
  s.email = ["phil.stewart@lichp.co.uk"]
  s.homepage = "http://github.com/lichp/multprimes"

  s.files = Dir[
    "lib/**/*.rb",
    "README*",
    "LICENSE",
    "bin/multprimes"
  ]

  s.bindir = 'bin'
  s.executables = 'multprimes'

  s.add_development_dependency "rspec", "~> 2"
end
