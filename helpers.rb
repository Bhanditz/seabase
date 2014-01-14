class SeabaseApp < Sinatra::Base
  helpers do

    def show_alignment(data)
      step = 51
      count = 0
      hseq = data.hseq 
      midline = data.midline
      qseq = data.qseq 
      res = ''
      while hseq[count...count + step] do
        res += hseq[count...count + step] + "<br/>"
        res += midline[count...count + step] + "<br/>"
        res += qseq[count...count + step] + "<br/>"
        count += step
      end
      res
    end

    def format_graph_data(table_data)
      res = table_data.transpose

      res.each_with_index do |r, i|
        next if i == 0
        res[i] = r.map { |n| n.round(2) }
      end

      res
    end
  end
end
