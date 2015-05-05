desc "Prepare the pi to be cooked"
task :prepare do
  system "bundle exec knife solo prepare --bootstrap-version 11.18.12 -VVV -x pi pi"
end

desc "Cook the pi"
task :cook do
  system "bundle exec knife solo cook -x pi pi"
end
