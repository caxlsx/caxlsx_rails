# frozen_string_literal: true

describe ExampleMailer do
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe '#send_attachment' do
    it 'attach a valid xlsx file' do
      expect { described_class.send_attachment(['one', 'two', 'three'], ['a', 'b', 'c']).deliver }
        .to change { ActionMailer::Base.deliveries }
          .from(be_empty)
          .to(contain_exactly(be_a(Mail::Message)))

      mail = ActionMailer::Base.deliveries.first

      expect(mail.attachments.first.content_type).to eql('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      validate_xlsx_file(mail.attachments.first.body.raw_source)
    end
  end
end
