describe Seabase::Normalizer do
  let(:transcript) { Transcript.where("name = 'comp114786_c0_seq1'").first }
  let(:id) { transcript.id }
  subject(:normalizer) do
    Seabase::Normalizer.new(
      Replicate.all(), [transcript],
      Transcript.connection.select_rows("
        SELECT mc.mapping_count, mc.replicate_id, #{id}
        FROM mapping_counts mc
        WHERE mc.transcript_id = #{id}"
      )
    )
  end
  let(:table) { normalizer.table }

  describe '.new' do
    it 'initializes' do
      expect(normalizer).to be_kind_of Seabase::Normalizer
    end
  end

  TABLE_RESULT = [
    [
      "A", 0.38129277692698793, 0.2535402924660262, -0.0026631099999999998,
      nil, nil, 0.6591691002963714, 0.3161825454159382, nil,
      0.7664659573371182, 1.2299616385384438, 0.5653960571661535,
      1.0847333888089137, -0.0050562133333333335, 0.8862766654390024,
      2.2706258581721954, 4.024742276112889, 7.931810633366208,
      2.0487917309622725, 7.926813217575848, 16.46753666796768
    ],
    [
      "B", -0.0005572200000000001, 0.2944935468608206, 0.19176329302333495,
      1.3482543201318884, 0.6552574068614394, nil, nil, -0.0015031733333333334,
      nil, nil, nil, 1.7201297145280396, 0.8433530858505321, 0.5708380469621759, 
      2.1985126371231614, 1.5870518941357397, 7.557185483850677,
      6.5703117198242795, 8.298508311414482, 6.634939318343579
    ],
    [
      "Average", 0.19036777846349395, 0.2740169196634234, 0.09455009151166748,
      1.3482543201318884, 0.6552574068614394, 0.6591691002963714,
      0.3161825454159382, -0.0015031733333333334, 0.7664659573371182,
      1.2299616385384438, 0.5653960571661535, 1.4024315516684767,
      0.41914843625859943, 0.7285573562005891, 2.2345692476476784,
      2.805897085124314, 7.744498058608443, 4.309551725393276,
      8.112660764495164, 11.55123799315563
    ]
  ]

  def my_compare(x, y)
  end

  describe '.table' do
    it 'has data' do
      expect(near_enough(table, TABLE_RESULT)).to be true
    end
  end
end
