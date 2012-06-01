module Staff
  class DB
    class << self
      # OPTIMIZE: maybe better use SQL?
      # This is for main page. When needed to return lates records from many tables
      def jouranl_all
        all_arr = []
        %w(Article Interview News).each do |m|
          all_arr = all_arr + eval(m).order('created_at DESC').limit(5)
        end
        all_arr.sort {|a,b| a[:created_at] <=> b[:created_at]}.last(5)
      end
    end
  end
end
