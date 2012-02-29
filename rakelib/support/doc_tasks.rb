# doc_tasks.rb
#   documentation generation tasks
#
# Created 2012-02-29 daveadams@gmail.com
# Last updated 2012-02-29 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

namespace :doc do
  SourceDir = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "doc"))
  GraphDir = File.join(SourceDir, "graphs")

  namespace :db do
    DbSourceDir = File.join(SourceDir, "db")

    task :ensure_graphviz_support do
      dot_path = `which dot 2>/dev/null`.chomp
      if dot_path.nil?
        STDERR.puts "ERROR: Graphviz 'dot' utility was not found in your PATH"
        exit 1
      else
        dot_version = `dot -V 2>&1`.chomp
        if dot_version !~ /Graphviz version/
          STDERR.puts "ERROR: The 'dot' utility in your PATH does not appear to be Graphviz"
          exit 1
        end
      end
    end

    task :create_graphs_dir do
      print "Creating directory for database graph files... "; STDOUT.flush
      system "mkdir -p #{GraphDir}"
      puts "OK"
    end

    desc "Create data relationship graphs"
    task :graphs => [ :ensure_graphviz_support, :create_graphs_dir ] do
      puts "Processing graphviz database files:"
      Dir[File.join(DbSourceDir, "*.gv")].each do |gv_file|
        print "  Processing #{File.basename(gv_file)}... ";STDOUT.flush
        system "dot -Tpng -o #{GraphDir}/#{File.basename(gv_file, ".gv")}.png #{gv_file}"
        puts "OK"
      end
    end
  end

  desc "Clean up generated docs"
  task :clean do
    puts "Deleting generated docs:"
    print "  Deleting doc/graphs... ";STDOUT.flush
    system "rm -rf #{GraphDir}"
    puts "OK"
  end
end

