module Vimpack
  module Utils
    module Process

      def run_process!(cmd)
        child = ::ChildProcess.build(*cmd.split(' '))
        child.start
        child
      end

      def run_process_or_die!(cmd, dir=nil)
        within_dir(dir) do 
          child = run_process!(cmd)
          child.poll_for_exit(30)
          child.stop unless child.exited?
          die!(child.io.stderr) unless child.exit_code == 0
        end
      end

      def within_dir(dir=nil, &block)
        orig_path = Dir.pwd
        dir = dir.nil? ? orig_path : dir.to_s
        ::Dir.chdir(dir)
        block.call
        ::Dir.chdir(orig_path)
      end

    end
  end
end
