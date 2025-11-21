def validate_xlsx_file(input, cell: [2, 3], value: 'c')
  wb = nil

  if Roo::VERSION.to_f < 3.0
    # TODO: on older Ruby versions we cannot use Roo V3
    File.open('/tmp/caxlsx_temp.xlsx', 'wb') { |f| f.write(StringIO.new(input).read) }
    expect { wb = Roo::Excelx.new('/tmp/caxlsx_temp.xlsx') }.to_not raise_error
  else
    xlsx_stream = StringIO.new(input)
    expect { wb = Roo::Excelx.new(xlsx_stream) }.not_to raise_error
  end

  expect(wb.cell(*cell)).to eq(value)
ensure
  if File.exist? '/tmp/caxlsx_temp.xlsx'
    File.unlink '/tmp/caxlsx_temp.xlsx'
  end
end
