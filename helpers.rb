helpers do

  include Rack::Utils
  alias_method :h, :escape_html
 
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
      element = []
      r.each_with_index do |n, ii| 
        cell_data = n
        if ii > 0 
          cell_data = format_cell_data(n)
        end
        element << cell_data
      end 
      res[i] = element
    end
    res.to_json
  end

  def format_cell_data(n)
    format = n ? n.round(2) : 'N/A'
    { v: n, f: format } 
  end

  def gene_type(external_name, opts = { capitalize: false })
    taxon = external_name.taxon.scientific_name
    res = nil
    if taxon == 'Nematostella vectensis'
      res = 'Nematostella annotation'
    else
      res = "%s ortholog" % external_name.taxon.common_name.downcase
    end

    if opts[:capitalize] 
      res = res.split(' ').map { |w| w.capitalize }.join(' ') 
    end
    res
  end
end
