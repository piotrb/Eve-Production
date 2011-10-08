require 'annotate/annotate_models'

desc "Add schema information (as comments) to model and fixture files"
task :annotate_models => :environment do
  ARGV = [] # annotate likes to pull in ARGV as extra params .. take them out
  options={}
  options[:position_in_class] = "before"
  options[:position_in_fixture] = "before"
  options[:show_indexes] = false
  AnnotateModels.do_annotations(options)
end

desc "Remove schema information from model and fixture files"
task :remove_annotation => :environment do
  require 'annotate/annotate_models'
  require 'my_annotate_models'
  options={}
  AnnotateModels.remove_annotations(options)
end

Rake::Task["db:migrate"].enhance do
  Rake::Task["annotate_models"].invoke
end if Rails.env.development?