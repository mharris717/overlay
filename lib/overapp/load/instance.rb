module Overapp
  module Load
    class Instance
      include FromHash
      attr_accessor :path, :overlays

      fattr(:starting_files) do
        Overapp::Files.new
      end

      fattr(:combined_files) do
        files = starting_files

        overlays.each do |overlay|
          files = apply_overlay(files,overlay)
        end

        files
      end

      def apply_overlay(base,overlay)
        Overapp::Git.commit(path,overlay.commit_message) do
          overlay.apply_to(base, :path => path)
        end
      end
    end
  end
end